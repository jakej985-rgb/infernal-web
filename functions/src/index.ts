import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { google } from 'googleapis';
import * as nodemailer from 'nodemailer';
import * as crypto from 'crypto';

admin.initializeApp();

const ALGORITHM = 'aes-256-cbc';

// Helper to get encryption key
function getSecretKey(): Buffer {
  const keyBase = process.env.SMTP_ENCRYPTION_KEY || 'infernal-ink-steel-suite-salt-key';
  return crypto.createHash('sha256').update(keyBase).digest();
}

// Encrypt helper
function encrypt(text: string): string {
  const iv = crypto.randomBytes(16);
  const cipher = crypto.createCipheriv(ALGORITHM, getSecretKey(), iv);
  let encrypted = cipher.update(text, 'utf8', 'hex');
  encrypted += cipher.final('hex');
  return `${iv.toString('hex')}:${encrypted}`;
}

// Decrypt helper
function decrypt(encryptedText: string): string {
  const parts = encryptedText.split(':');
  if (parts.length !== 2) throw new Error('Invalid encrypted text format');
  const iv = Buffer.from(parts[0], 'hex');
  const encrypted = parts[1];
  const decipher = crypto.createDecipheriv(ALGORITHM, getSecretKey(), iv);
  let decrypted = decipher.update(encrypted, 'hex', 'utf8');
  decrypted += decipher.final('utf8');
  return decrypted;
}

// Get Google OAuth2 Client
async function getOAuth2Client(orgId: string): Promise<any> {
  const db = admin.firestore();

  const clientId = process.env.GOOGLE_CLIENT_ID || functions.config().google?.client_id;
  const clientSecret = process.env.GOOGLE_CLIENT_SECRET || functions.config().google?.client_secret;
  const redirectUri = process.env.GOOGLE_REDIRECT_URI || functions.config().google?.redirect_uri || `https://us-central1-${process.env.GCLOUD_PROJECT}.cloudfunctions.net/authGoogleCallback`;

  if (!clientId || !clientSecret || !redirectUri) {
    throw new functions.https.HttpsError(
      'failed-precondition',
      'Google OAuth credentials not configured on the server.'
    );
  }

  const oauth2Client = new google.auth.OAuth2(clientId, clientSecret, redirectUri);

  const privateDocRef = db.collection('organizations').doc(orgId).collection('integration_private').doc('main');
  const privateDoc = await privateDocRef.get();

  if (!privateDoc.exists) {
    throw new functions.https.HttpsError(
      'not-found',
      'Google integration details not found for this organization.'
    );
  }

  const secrets = privateDoc.data()?.google;
  if (!secrets || !secrets.refresh_token) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'Google integration is not connected.'
    );
  }

  oauth2Client.setCredentials({
    access_token: secrets.access_token,
    refresh_token: secrets.refresh_token,
    expiry_date: secrets.expiry_date
  });

  // Auto-refresh token if expired (or expiring in < 5 mins)
  const now = Date.now();
  if (!secrets.expiry_date || secrets.expiry_date - now < 5 * 60 * 1000) {
    try {
      const { credentials } = await oauth2Client.refreshAccessToken();
      const updateData: any = {
        'google.access_token': credentials.access_token,
      };
      if (credentials.expiry_date) {
        updateData['google.expiry_date'] = credentials.expiry_date;
      }
      await privateDocRef.update(updateData);
      oauth2Client.setCredentials(credentials);
    } catch (err) {
      console.error(`Error refreshing Google token for org ${orgId}:`, err);
      throw new functions.https.HttpsError(
        'unauthenticated',
        'Google credentials expired and failed to refresh. Please reconnect.'
      );
    }
  }

  return oauth2Client;
}

// Helper to get or create a dedicated calendar for the organization
async function getOrCreateCalendar(oauth2Client: any, orgId: string): Promise<string> {
  const db = admin.firestore();
  const privateDocRef = db.collection('organizations').doc(orgId).collection('integration_private').doc('main');
  const privateDoc = await privateDocRef.get();

  let calendarId = privateDoc.data()?.google?.calendarId;
  if (calendarId) {
    return calendarId;
  }

  let orgName = 'Studio';
  try {
    const orgDoc = await db.collection('organizations').doc(orgId).get();
    if (orgDoc.exists) {
      orgName = orgDoc.data()?.name || orgName;
    }
  } catch (err) {
    console.warn(`Failed to fetch organization name:`, err);
  }

  const calendar = google.calendar({ version: 'v3', auth: oauth2Client });
  const calendarTitle = 'Ink & Steel';

  try {
    const listResponse = await calendar.calendarList.list({ minAccessRole: 'owner' });
    const existing = (listResponse.data.items || []).find(
      (entry: any) => entry.summary === calendarTitle
    );
    if (existing) {
      calendarId = existing.id;
    }
  } catch (err) {
    console.warn(`Failed to list calendars:`, err);
  }

  if (!calendarId) {
    try {
      const createResponse = await calendar.calendars.insert({
        requestBody: {
          summary: calendarTitle,
          timeZone: 'UTC'
        }
      });
      calendarId = createResponse.data.id;
    } catch (createErr) {
      console.error(`Failed to create new Google Calendar:`, createErr);
      return 'primary';
    }
  }

  if (calendarId && calendarId !== 'primary') {
    await privateDocRef.set({
      google: {
        calendarId: calendarId
      }
    }, { merge: true });
  }

  return calendarId || 'primary';
}

// 1. HTTP Endpoint to initiate Google OAuth Flow
export const authGoogle = functions.https.onRequest(async (req, res) => {
  const orgId = req.query.orgId as string;
  const redirectUrl = (req.query.redirectUrl as string) || '';

  if (!orgId) {
    res.status(400).send('Missing orgId query parameter.');
    return;
  }

  const clientId = process.env.GOOGLE_CLIENT_ID || functions.config().google?.client_id;
  const clientSecret = process.env.GOOGLE_CLIENT_SECRET || functions.config().google?.client_secret;
  const redirectUri = process.env.GOOGLE_REDIRECT_URI || functions.config().google?.redirect_uri || `https://us-central1-${process.env.GCLOUD_PROJECT}.cloudfunctions.net/authGoogleCallback`;

  if (!clientId || !clientSecret || !redirectUri) {
    res.status(500).send('Google OAuth configuration is missing on the server.');
    return;
  }

  const oauth2Client = new google.auth.OAuth2(clientId, clientSecret, redirectUri);

  const state = JSON.stringify({ orgId, redirectUrl });
  const scopes = [
    'openid',
    'email',
    'profile',
    'https://www.googleapis.com/auth/gmail.send',
    'https://www.googleapis.com/auth/calendar',
    'https://www.googleapis.com/auth/contacts'
  ];

  const authUrl = oauth2Client.generateAuthUrl({
    access_type: 'offline',
    prompt: 'consent',
    scope: scopes,
    state: state
  });

  res.redirect(authUrl);
});

// 2. HTTP Endpoint callback handler for Google OAuth Flow
export const authGoogleCallback = functions.https.onRequest(async (req, res) => {
  const code = req.query.code as string;
  const stateStr = req.query.state as string;

  if (!code || !stateStr) {
    res.status(400).send('Missing code or state parameters.');
    return;
  }

  let orgId = '';
  let redirectUrl = '';
  try {
    const parsedState = JSON.parse(stateStr);
    orgId = parsedState.orgId;
    redirectUrl = parsedState.redirectUrl;
  } catch (err) {
    res.status(400).send('Invalid state parameter.');
    return;
  }

  const clientId = process.env.GOOGLE_CLIENT_ID || functions.config().google?.client_id;
  const clientSecret = process.env.GOOGLE_CLIENT_SECRET || functions.config().google?.client_secret;
  const redirectUri = process.env.GOOGLE_REDIRECT_URI || functions.config().google?.redirect_uri || `https://us-central1-${process.env.GCLOUD_PROJECT}.cloudfunctions.net/authGoogleCallback`;

  const oauth2Client = new google.auth.OAuth2(clientId, clientSecret, redirectUri);

  try {
    const { tokens } = await oauth2Client.getToken(code);
    oauth2Client.setCredentials(tokens);

    const oauth2 = google.oauth2({ version: 'v2', auth: oauth2Client });
    const userInfo = await oauth2.userinfo.get();
    const email = userInfo.data.email || '';

    const db = admin.firestore();

    // Store private credentials
    await db.collection('organizations').doc(orgId).collection('integration_private').doc('main').set({
      google: {
        access_token: tokens.access_token,
        refresh_token: tokens.refresh_token,
        expiry_date: tokens.expiry_date,
      }
    }, { merge: true });

    // Store public integration state
    await db.collection('organizations').doc(orgId).collection('settings').doc('integration').set({
      type: 'google',
      google: {
        connected: true,
        email: email,
        scopes: tokens.scope ? tokens.scope.split(' ') : []
      },
      smtp: { connected: false }
    }, { merge: true });

    if (redirectUrl) {
      res.redirect(redirectUrl);
    } else {
      res.send('Google Account connected successfully! You may close this tab and return to the app.');
    }
  } catch (err: any) {
    console.error('OAuth Callback Error:', err);
    res.status(500).send(`Authentication failed: ${err.message}`);
  }
});

// 3. Callable: Save SMTP Configuration
export const saveSmtpConfig = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be logged in.');
  }

  const { orgId, host, port, user, password } = data;
  if (!orgId || !host || !port || !user || !password) {
    throw new functions.https.HttpsError('invalid-argument', 'Missing SMTP configuration details.');
  }

  const db = admin.firestore();

  try {
    const encryptedPass = encrypt(password);

    // Save private password
    await db.collection('organizations').doc(orgId).collection('integration_private').doc('main').set({
      smtp: {
        encrypted_pass: encryptedPass
      }
    }, { merge: true });

    // Save public settings
    await db.collection('organizations').doc(orgId).collection('settings').doc('integration').set({
      type: 'smtp',
      smtp: {
        connected: true,
        host: host,
        port: parseInt(port, 10),
        user: user
      },
      google: { connected: false }
    }, { merge: true });

    return { success: true };
  } catch (err: any) {
    throw new functions.https.HttpsError('internal', `Failed to save SMTP config: ${err.message}`);
  }
});

// 4. Callable: Test SMTP Connection (before saving)
export const testSmtpConnection = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be logged in.');
  }

  const { host, port, user, password } = data;
  if (!host || !port || !user || !password) {
    throw new functions.https.HttpsError('invalid-argument', 'Missing SMTP testing credentials.');
  }

  try {
    const transporter = nodemailer.createTransport({
      host: host,
      port: parseInt(port, 10),
      secure: parseInt(port, 10) === 465,
      auth: { user, pass: password },
      connectionTimeout: 10000 // 10s timeout
    });

    await transporter.verify();

    // Send a test email to the user
    await transporter.sendMail({
      from: user,
      to: user,
      subject: 'Infernal Ink & Steel - SMTP Connection Test',
      text: 'Thy connection to the SMTP server is verified and active.'
    });

    return { success: true };
  } catch (err: any) {
    throw new functions.https.HttpsError('invalid-argument', `SMTP validation failed: ${err.message}`);
  }
});

// 5. Callable: Disconnect Integration
export const disconnectIntegration = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be logged in.');
  }

  const { orgId } = data;
  if (!orgId) {
    throw new functions.https.HttpsError('invalid-argument', 'Missing organization ID.');
  }

  const db = admin.firestore();

  try {
    // Delete secrets
    await db.collection('organizations').doc(orgId).collection('integration_private').doc('main').delete();

    // Clear public integration settings
    await db.collection('organizations').doc(orgId).collection('settings').doc('integration').set({
      type: null,
      google: { connected: false },
      smtp: { connected: false }
    }, { merge: true });

    return { success: true };
  } catch (err: any) {
    throw new functions.https.HttpsError('internal', `Failed to disconnect integration: ${err.message}`);
  }
});

// 6. Callable: Get Google Contacts
export const getGoogleContacts = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be logged in.');
  }

  const { orgId } = data;
  if (!orgId) {
    throw new functions.https.HttpsError('invalid-argument', 'Missing organization ID.');
  }

  try {
    const oauth2Client = await getOAuth2Client(orgId);
    const people = google.people({ version: 'v1', auth: oauth2Client });

    const response = await people.people.connections.list({
      resourceName: 'people/me',
      pageSize: 100,
      personFields: 'names,emailAddresses,phoneNumbers'
    });

    const contacts = (response.data.connections || []).map((person: any) => {
      const name = person.names?.[0]?.displayName || 'Unknown Name';
      const email = person.emailAddresses?.[0]?.value || '';
      const phone = person.phoneNumbers?.[0]?.value || '';
      return { name, email, phone };
    });

    return { contacts };
  } catch (err: any) {
    throw new functions.https.HttpsError('internal', `Google Contacts fetch failed: ${err.message}`);
  }
});

// 6.5. Callable: Force Sync All Appointments to Google Calendar
export const syncAllAppointments = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be logged in.');
  }

  const { orgId } = data;
  if (!orgId) {
    throw new functions.https.HttpsError('invalid-argument', 'Missing organization ID.');
  }

  const db = admin.firestore();

  try {
    const publicDoc = await db.collection('organizations').doc(orgId).collection('settings').doc('integration').get();
    if (!publicDoc.exists || publicDoc.data()?.type !== 'google') {
      throw new functions.https.HttpsError('failed-precondition', 'Google integration is not active.');
    }

    const oauth2Client = await getOAuth2Client(orgId);
    const calendar = google.calendar({ version: 'v3', auth: oauth2Client });
    const calendarId = await getOrCreateCalendar(oauth2Client, orgId);

    // Fetch all appointments
    const apptsSnapshot = await db.collection('organizations').doc(orgId).collection('appointments').get();

    let successCount = 0;
    let failureCount = 0;

    for (const doc of apptsSnapshot.docs) {
      const apptData = doc.data();
      const apptId = doc.id;

      // Skip soft-deleted appointments
      if (apptData.isDeleted === true) {
        continue;
      }

      // Check start_time and end_time
      if (!apptData.start_time || !apptData.end_time) {
        continue;
      }

      try {
        const event = {
          summary: apptData.title || 'Tattoo Appointment',
          description: apptData.notes || '',
          start: {
            dateTime: new Date(apptData.start_time).toISOString(),
          },
          end: {
            dateTime: new Date(apptData.end_time).toISOString(),
          }
        };

        if (apptData.googleEventId) {
          try {
            await calendar.events.update({
              calendarId,
              eventId: apptData.googleEventId,
              requestBody: event
            });
            successCount++;
          } catch (updateErr: any) {
            // If the event was deleted on Google Calendar side (404/410), recreate it
            if (updateErr.code === 404 || updateErr.code === 410) {
              const response = await calendar.events.insert({
                calendarId,
                requestBody: event
              });
              const googleEventId = response.data.id;
              if (googleEventId) {
                await doc.ref.update({ googleEventId });
              }
              successCount++;
            } else {
              console.error(`Failed to update event ${apptData.googleEventId} for appt ${apptId}:`, updateErr);
              failureCount++;
            }
          }
        } else {
          const response = await calendar.events.insert({
            calendarId,
            requestBody: event
          });
          const googleEventId = response.data.id;
          if (googleEventId) {
            await doc.ref.update({ googleEventId });
          }
          successCount++;
        }
      } catch (apptErr) {
        console.error(`Failed to sync appointment ${apptId}:`, apptErr);
        failureCount++;
      }
    }

    return { success: true, synced: successCount, failed: failureCount };
  } catch (err: any) {
    throw new functions.https.HttpsError('internal', `Force sync failed: ${err.message}`);
  }
});

// Utility: Build RFC 2822 raw message format for Gmail API
function makeGmailBody(to: string, from: string, subject: string, htmlMessage: string): string {
  const str = [
    `To: ${to}\r\n`,
    `From: ${from}\r\n`,
    `Subject: =?utf-8?B?${Buffer.from(subject).toString('base64')}?=\r\n`,
    "MIME-Version: 1.0\r\n",
    "Content-Type: text/html; charset=\"UTF-8\"\r\n\r\n",
    htmlMessage
  ].join('');

  return Buffer.from(str)
    .toString("base64")
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=+$/, "");
}

// 7. Firestore Trigger: Auto-send emails when created with status 'PENDING'
export const onCommunicationCreated = functions.firestore
  .document('organizations/{orgId}/communications/{commId}')
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();
    const { orgId, commId } = context.params;

    if (!data || data.type !== 'Email' || data.direction !== 'OUTBOUND' || data.status !== 'PENDING') {
      return;
    }

    let to = data.client_email || '';
    const subject = data.subject || 'Ritual Confirmation';
    const body = data.content || '';

    const db = admin.firestore();

    if (!to && data.client_id) {
      try {
        const clientDoc = await db.collection('organizations').doc(orgId).collection('clients').doc(data.client_id).get();
        if (clientDoc.exists) {
          to = clientDoc.data()?.email || '';
        }
      } catch (err) {
        console.error(`Failed to fetch client email for client ${data.client_id}:`, err);
      }
    }

    if (!to || !body) {
      console.warn(`Skipping send for comm ${commId} in org ${orgId}: recipient or body missing.`);
      await snapshot.ref.update({
        status: 'FAILED',
        error: !to ? 'Recipient email address missing.' : 'Email body content missing.'
      });
      return;
    }

    try {
      const publicDoc = await db.collection('organizations').doc(orgId).collection('settings').doc('integration').get();
      const type = publicDoc.exists ? publicDoc.data()?.type : null;

      if (type === 'google') {
        const oauth2Client = await getOAuth2Client(orgId);
        const gmail = google.gmail({ version: 'v1', auth: oauth2Client });
        const fromEmail = publicDoc.data()?.google?.email || 'me';

        await gmail.users.messages.send({
          userId: 'me',
          requestBody: {
            raw: makeGmailBody(to, fromEmail, subject, body)
          }
        });
      } else if (type === 'smtp') {
        const smtpPublic = publicDoc.data()?.smtp;
        const privateDoc = await db.collection('organizations').doc(orgId).collection('integration_private').doc('main').get();
        const smtpPrivate = privateDoc.exists ? privateDoc.data()?.smtp : null;

        if (!smtpPublic || !smtpPrivate || !smtpPrivate.encrypted_pass) {
          throw new Error('SMTP configuration is incomplete.');
        }

        const pass = decrypt(smtpPrivate.encrypted_pass);
        const transporter = nodemailer.createTransport({
          host: smtpPublic.host,
          port: smtpPublic.port,
          secure: smtpPublic.port === 465,
          auth: { user: smtpPublic.user, pass: pass }
        });

        await transporter.sendMail({
          from: smtpPublic.user,
          to: to,
          subject: subject,
          html: body
        });
      } else {
        throw new Error('No active email integration (Google/SMTP) connected.');
      }

      // Update communication status in Firestore
      await snapshot.ref.update({
        status: 'SENT',
        sentAt: admin.firestore.FieldValue.serverTimestamp()
      });
    } catch (err: any) {
      console.error(`Failed to send communication ${commId}:`, err);
      await snapshot.ref.update({
        status: 'FAILED',
        error: err.message,
        sentAt: admin.firestore.FieldValue.serverTimestamp()
      });
    }
  });

// 8. Firestore Triggers: Google Calendar Synchronization for Appointments
export const onAppointmentCreated = functions.firestore
  .document('organizations/{orgId}/appointments/{apptId}')
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();
    const { orgId, apptId } = context.params;

    if (!data || data.isDeleted) return;

    const db = admin.firestore();

    try {
      const publicDoc = await db.collection('organizations').doc(orgId).collection('settings').doc('integration').get();
      if (!publicDoc.exists || publicDoc.data()?.type !== 'google') return;

      const oauth2Client = await getOAuth2Client(orgId);
      const calendar = google.calendar({ version: 'v3', auth: oauth2Client });
      const calendarId = await getOrCreateCalendar(oauth2Client, orgId);

      const event = {
        summary: data.title || 'Tattoo Appointment',
        description: data.notes || '',
        start: {
          dateTime: new Date(data.start_time).toISOString(),
        },
        end: {
          dateTime: new Date(data.end_time).toISOString(),
        }
      };

      const response = await calendar.events.insert({
        calendarId,
        requestBody: event
      });

      const googleEventId = response.data.id;
      if (googleEventId) {
        await snapshot.ref.update({ googleEventId });
      }
    } catch (err) {
      console.error(`Failed to sync newly created appointment ${apptId} to Google Calendar:`, err);
    }
  });

export const onAppointmentUpdated = functions.firestore
  .document('organizations/{orgId}/appointments/{apptId}')
  .onUpdate(async (change, context) => {
    const beforeData = change.before.data();
    const afterData = change.after.data();
    const { orgId, apptId } = context.params;

    if (!afterData) return;

    // Prevent infinite loop if we only updated googleEventId
    if (beforeData?.googleEventId !== afterData?.googleEventId) {
      return;
    }

    const db = admin.firestore();

    try {
      const publicDoc = await db.collection('organizations').doc(orgId).collection('settings').doc('integration').get();
      if (!publicDoc.exists || publicDoc.data()?.type !== 'google') return;

      const oauth2Client = await getOAuth2Client(orgId);
      const calendar = google.calendar({ version: 'v3', auth: oauth2Client });
      const calendarId = await getOrCreateCalendar(oauth2Client, orgId);

      // Handle soft delete update
      if (afterData.isDeleted && !beforeData.isDeleted) {
        if (afterData.googleEventId) {
          await calendar.events.delete({
            calendarId,
            eventId: afterData.googleEventId
          });
          await change.after.ref.update({ googleEventId: admin.firestore.FieldValue.delete() });
        }
        return;
      }

      const event = {
        summary: afterData.title || 'Tattoo Appointment',
        description: afterData.notes || '',
        start: {
          dateTime: new Date(afterData.start_time).toISOString(),
        },
        end: {
          dateTime: new Date(afterData.end_time).toISOString(),
        }
      };

      if (afterData.googleEventId) {
        await calendar.events.update({
          calendarId,
          eventId: afterData.googleEventId,
          requestBody: event
        });
      } else {
        // Create if missing
        const response = await calendar.events.insert({
          calendarId,
          requestBody: event
        });
        const googleEventId = response.data.id;
        if (googleEventId) {
          await change.after.ref.update({ googleEventId });
        }
      }
    } catch (err) {
      console.error(`Failed to sync updated appointment ${apptId} to Google Calendar:`, err);
    }
  });

export const onAppointmentDeleted = functions.firestore
  .document('organizations/{orgId}/appointments/{apptId}')
  .onDelete(async (snapshot, context) => {
    const data = snapshot.data();
    const { orgId, apptId } = context.params;

    if (!data || !data.googleEventId) return;

    const db = admin.firestore();

    try {
      const publicDoc = await db.collection('organizations').doc(orgId).collection('settings').doc('integration').get();
      if (!publicDoc.exists || publicDoc.data()?.type !== 'google') return;

      const oauth2Client = await getOAuth2Client(orgId);
      const calendar = google.calendar({ version: 'v3', auth: oauth2Client });
      const calendarId = await getOrCreateCalendar(oauth2Client, orgId);

      await calendar.events.delete({
        calendarId,
        eventId: data.googleEventId
      });
    } catch (err) {
      console.error(`Failed to delete appointment ${apptId} from Google Calendar:`, err);
    }
  });

// 9. Firestore Triggers: Google Contacts Sync for Clients
export const onClientCreated = functions.firestore
  .document('organizations/{orgId}/clients/{clientId}')
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();
    const { orgId, clientId } = context.params;

    if (!data || data.isDeleted) return;

    const db = admin.firestore();
    try {
      const publicDoc = await db.collection('organizations').doc(orgId).collection('settings').doc('integration').get();
      if (!publicDoc.exists || publicDoc.data()?.type !== 'google') return;

      const oauth2Client = await getOAuth2Client(orgId);
      const people = google.people({ version: 'v1', auth: oauth2Client });

      const name = data.name || `${data.first_name || ''} ${data.last_name || ''}`.trim();

      const response = await people.people.createContact({
        requestBody: {
          names: [
            {
              givenName: data.first_name || name,
              familyName: data.last_name || '',
            }
          ],
          emailAddresses: data.email ? [{ value: data.email }] : undefined,
          phoneNumbers: data.phone ? [{ value: data.phone }] : undefined,
          biographies: data.notes ? [{ value: data.notes }] : undefined,
        }
      });

      const googleContactResourceName = response.data.resourceName;
      if (googleContactResourceName) {
        await snapshot.ref.update({ googleContactResourceName });
      }
    } catch (err) {
      console.error(`Failed to sync newly created client ${clientId} to Google Contacts:`, err);
    }
  });

export const onClientUpdated = functions.firestore
  .document('organizations/{orgId}/clients/{clientId}')
  .onUpdate(async (change, context) => {
    const beforeData = change.before.data();
    const afterData = change.after.data();
    const { orgId, clientId } = context.params;

    if (!afterData) return;

    // Prevent infinite loop if we only updated googleContactResourceName
    if (beforeData?.googleContactResourceName !== afterData?.googleContactResourceName) {
      return;
    }

    const db = admin.firestore();
    try {
      const publicDoc = await db.collection('organizations').doc(orgId).collection('settings').doc('integration').get();
      if (!publicDoc.exists || publicDoc.data()?.type !== 'google') return;

      const oauth2Client = await getOAuth2Client(orgId);
      const people = google.people({ version: 'v1', auth: oauth2Client });

      // Handle soft delete update
      if (afterData.isDeleted && !beforeData.isDeleted) {
        if (afterData.googleContactResourceName) {
          try {
            await people.people.deleteContact({
              resourceName: afterData.googleContactResourceName
            });
          } catch (deleteErr) {
            console.error(`Failed to delete contact from Google on soft delete:`, deleteErr);
          }
          await change.after.ref.update({ googleContactResourceName: admin.firestore.FieldValue.delete() });
        }
        return;
      }

      const name = afterData.name || `${afterData.first_name || ''} ${afterData.last_name || ''}`.trim();

      const contactData = {
        names: [
          {
            givenName: afterData.first_name || name,
            familyName: afterData.last_name || '',
          }
        ],
        emailAddresses: afterData.email ? [{ value: afterData.email }] : [],
        phoneNumbers: afterData.phone ? [{ value: afterData.phone }] : [],
        biographies: afterData.notes ? [{ value: afterData.notes }] : [],
      };

      if (afterData.googleContactResourceName) {
        try {
          // Fetch the contact first to obtain current etag
          const existingContact = await people.people.get({
            resourceName: afterData.googleContactResourceName,
            personFields: 'names,emailAddresses,phoneNumbers,biographies'
          });

          await people.people.updateContact({
            resourceName: afterData.googleContactResourceName,
            updatePersonFields: 'names,emailAddresses,phoneNumbers,biographies',
            requestBody: {
              etag: existingContact.data.etag,
              ...contactData
            }
          });
        } catch (updateErr: any) {
          // If deleted on Google side (404/410), recreate it
          if (updateErr.code === 404 || updateErr.code === 410) {
            const response = await people.people.createContact({
              requestBody: contactData
            });
            const googleContactResourceName = response.data.resourceName;
            if (googleContactResourceName) {
              await change.after.ref.update({ googleContactResourceName });
            }
          } else {
            console.error(`Failed to update Google Contact ${afterData.googleContactResourceName} for client ${clientId}:`, updateErr);
          }
        }
      } else {
        // Create if missing and not deleted
        if (!afterData.isDeleted) {
          const response = await people.people.createContact({
            requestBody: contactData
          });
          const googleContactResourceName = response.data.resourceName;
          if (googleContactResourceName) {
            await change.after.ref.update({ googleContactResourceName });
          }
        }
      }
    } catch (err) {
      console.error(`Failed to sync updated client ${clientId} to Google Contacts:`, err);
    }
  });

export const onClientDeleted = functions.firestore
  .document('organizations/{orgId}/clients/{clientId}')
  .onDelete(async (snapshot, context) => {
    const data = snapshot.data();
    const { orgId, clientId } = context.params;

    if (!data || !data.googleContactResourceName) return;

    const db = admin.firestore();
    try {
      const publicDoc = await db.collection('organizations').doc(orgId).collection('settings').doc('integration').get();
      if (!publicDoc.exists || publicDoc.data()?.type !== 'google') return;

      const oauth2Client = await getOAuth2Client(orgId);
      const people = google.people({ version: 'v1', auth: oauth2Client });

      await people.people.deleteContact({
        resourceName: data.googleContactResourceName
      });
    } catch (err) {
      console.error(`Failed to delete client ${clientId} from Google Contacts:`, err);
    }
  });

