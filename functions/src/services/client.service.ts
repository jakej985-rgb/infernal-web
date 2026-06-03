import * as admin from "firebase-admin";

export interface CreateClientDTO {
  name: string;
  email?: string;
  phone?: string;
}

/**
 * Service to manage client records in Firestore under an organization namespace.
 */
export class ClientService {
  /**
   * Helper to retrieve the clients subcollection.
   * @param orgId The organization ID
   */
  private getClientsCollection(orgId: string) {
    return admin.firestore()
      .collection("organizations")
      .doc(orgId)
      .collection("clients");
  }

  /**
   * Creates a new client under the specified organization.
   * @param orgId The organization ID
   * @param clientData Client creation data
   */
  async createClient(
    orgId: string,
    clientData: CreateClientDTO
  ): Promise<string> {
    const docRef = this.getClientsCollection(orgId).doc();

    await docRef.set({
      name: clientData.name,
      email: clientData.email || "",
      phone: clientData.phone || "",
      isDeleted: false,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return docRef.id;
  }
}
