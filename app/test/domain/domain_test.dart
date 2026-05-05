import 'package:flutter_test/flutter_test.dart';
import 'package:infernal_ink_steel/shared/domain/domain.dart';

void main() {
  group('Client', () {
    test('should create with required fields', () {
      final client = Client(
        id: 1,
        syncId: 'abc-123',
        firstName: 'John',
        lastName: 'Doe',
        lastModifiedUtc: DateTime.utc(2026, 1, 21),
      );

      expect(client.id, 1);
      expect(client.firstName, 'John');
      expect(client.lastName, 'Doe');
      expect(client.fullName, 'John Doe');
    });

    test('should compute fullName with middle name', () {
      final client = Client(
        id: 1,
        syncId: 'abc-123',
        firstName: 'John',
        middleName: 'William',
        lastName: 'Doe',
        lastModifiedUtc: DateTime.utc(2026, 1, 21),
      );

      expect(client.fullName, 'John William Doe');
    });

    test('should serialize to JSON and back', () {
      final client = Client(
        id: 1,
        syncId: 'abc-123',
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com',
        phone: '555-1234',
        status: ClientStatus.highValue,
        lastModifiedUtc: DateTime.utc(2026, 1, 21),
      );

      final json = client.toJson();
      final restored = Client.fromJson(json);

      expect(restored.id, client.id);
      expect(restored.firstName, client.firstName);
      expect(restored.email, client.email);
      expect(restored.status, ClientStatus.highValue);
    });

    test('should copyWith correctly', () {
      final client = Client(
        id: 1,
        syncId: 'abc-123',
        firstName: 'John',
        lastName: 'Doe',
        lastModifiedUtc: DateTime.utc(2026, 1, 21),
      );

      final updated = client.copyWith(firstName: 'Jane', visits: 5);

      expect(updated.firstName, 'Jane');
      expect(updated.visits, 5);
      expect(updated.lastName, 'Doe'); // Unchanged
    });
  });

  group('User', () {
    test('should create with required fields', () {
      final user = User(
        id: 1,
        username: 'artist1',
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 21),
      );

      expect(user.id, 1);
      expect(user.username, 'artist1');
      expect(user.role, UserRole.artist);
      expect(user.isAdmin, false);
    });

    test('should detect admin role', () {
      final admin = User(
        id: 1,
        username: 'admin',
        role: UserRole.admin,
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 21),
      );

      expect(admin.isAdmin, true);
    });

    test(
      'should use username as effective display name if displayName empty',
      () {
        final user = User(
          id: 1,
          username: 'artist1',
          createdAt: DateTime.utc(2026, 1, 1),
          updatedAt: DateTime.utc(2026, 1, 21),
        );

        expect(user.effectiveDisplayName, 'artist1');
      },
    );

    test('should serialize to JSON and back', () {
      final user = User(
        id: 1,
        username: 'test',
        displayName: 'Test User',
        role: UserRole.admin,
        hourlyRate: 175.0,
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 21),
      );

      final json = user.toJson();
      final restored = User.fromJson(json);

      expect(restored.username, user.username);
      expect(restored.displayName, 'Test User');
      expect(restored.role, UserRole.admin);
      expect(restored.hourlyRate, 175.0);
    });
  });

  group('Appointment', () {
    test('should create with required fields', () {
      final appt = Appointment(
        id: 1,
        syncId: 'appt-123',
        clientId: 10,
        userId: 5,
        dateTime: DateTime.utc(2026, 1, 21, 14, 0),
        durationMinutes: 120,
        lastModifiedUtc: DateTime.utc(2026, 1, 21),
      );

      expect(appt.id, 1);
      expect(appt.clientId, 10);
      expect(appt.artistId, 5); // Alias
      expect(appt.durationMinutes, 120);
    });

    test('should compute endTime correctly', () {
      final start = DateTime.utc(2026, 1, 21, 14, 0);
      final appt = Appointment(
        id: 1,
        syncId: 'appt-123',
        clientId: 10,
        userId: 5,
        dateTime: start,
        durationMinutes: 90,
        lastModifiedUtc: DateTime.utc(2026, 1, 21),
      );

      expect(appt.endTime, DateTime.utc(2026, 1, 21, 15, 30));
    });

    test('should parse status string to enum', () {
      final appt = Appointment(
        id: 1,
        syncId: 'appt-123',
        clientId: 10,
        userId: 5,
        dateTime: DateTime.utc(2026, 1, 21, 14, 0),
        durationMinutes: 60,
        status: 'Completed',
        lastModifiedUtc: DateTime.utc(2026, 1, 21),
      );

      expect(appt.statusEnum, AppointmentStatus.completed);
    });

    test('should serialize to JSON and back', () {
      final appt = Appointment(
        id: 1,
        syncId: 'appt-123',
        clientId: 10,
        userId: 5,
        dateTime: DateTime.utc(2026, 1, 21, 14, 0),
        durationMinutes: 60,
        serviceType: 'Tattoo',
        priceCharged: 250.0,
        lastModifiedUtc: DateTime.utc(2026, 1, 21),
      );

      final json = appt.toJson();
      final restored = Appointment.fromJson(json);

      expect(restored.id, appt.id);
      expect(restored.serviceType, 'Tattoo');
      expect(restored.priceCharged, 250.0);
    });
  });

  group('Quote', () {
    test('should create with required fields', () {
      final quote = Quote(
        id: 1,
        artistId: 5,
        createdAt: DateTime.utc(2026, 1, 21),
      );

      expect(quote.id, 1);
      expect(quote.artistId, 5);
      expect(quote.isCoverUp, false);
    });

    test('should compute area correctly', () {
      final quote = Quote(
        id: 1,
        artistId: 5,
        width: 10,
        height: 15,
        createdAt: DateTime.utc(2026, 1, 21),
      );

      expect(quote.area, 150);
    });

    test('should compute average complexity', () {
      final quote = Quote(
        id: 1,
        artistId: 5,
        lineComplexity: 4,
        shadingComplexity: 3,
        colorComplexity: 5,
        difficulty: 4,
        createdAt: DateTime.utc(2026, 1, 21),
      );

      expect(quote.averageComplexity, 4.0);
    });

    test('should format price range', () {
      final quote = Quote(
        id: 1,
        artistId: 5,
        priceLow: 250,
        priceHigh: 400,
        createdAt: DateTime.utc(2026, 1, 21),
      );

      expect(quote.priceRangeFormatted, '\$250 - \$400');
    });

    test('should serialize to JSON and back', () {
      final quote = Quote(
        id: 1,
        artistId: 5,
        placement: 'Upper Arm',
        style: 'Traditional',
        priceLow: 200,
        priceHigh: 350,
        createdAt: DateTime.utc(2026, 1, 21),
      );

      final json = quote.toJson();
      final restored = Quote.fromJson(json);

      expect(restored.placement, 'Upper Arm');
      expect(restored.style, 'Traditional');
    });
  });

  group('Document', () {
    test('should detect file extension', () {
      final doc = Document(
        id: 1,
        syncId: 'doc-123',
        uploadedByUserId: 1,
        clientId: 10,
        title: 'Waiver',
        filePath: '/uploads/waiver.pdf',
        createdAt: DateTime.utc(2026, 1, 21),
        lastModifiedUtc: DateTime.utc(2026, 1, 21),
      );

      expect(doc.fileExtension, 'pdf');
      expect(doc.isPdf, true);
      expect(doc.isImage, false);
    });

    test('should detect image files', () {
      final doc = Document(
        id: 1,
        syncId: 'doc-123',
        uploadedByUserId: 1,
        clientId: 10,
        title: 'Reference',
        filePath: '/uploads/reference.jpg',
        createdAt: DateTime.utc(2026, 1, 21),
        lastModifiedUtc: DateTime.utc(2026, 1, 21),
      );

      expect(doc.isImage, true);
      expect(doc.isPdf, false);
    });
  });

  group('ShopSettings', () {
    test('should have sensible defaults', () {
      final settings = ShopSettings(
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 21),
      );

      expect(settings.tattooPerHour, 150.0);
      expect(settings.shopMinimumRate, 100.0);
      expect(settings.depositType, DepositType.percentage);
    });

    test('should calculate deposit correctly for percentage', () {
      final settings = ShopSettings(
        depositType: DepositType.percentage,
        depositAmount: 20.0,
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 21),
      );

      expect(settings.calculateDeposit(500), 100.0);
    });

    test('should calculate deposit correctly for fixed', () {
      final settings = ShopSettings(
        depositType: DepositType.fixed,
        depositAmount: 75.0,
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 21),
      );

      expect(settings.calculateDeposit(500), 75.0);
    });

    test('should calculate price with tax', () {
      final settings = ShopSettings(
        taxRate: 0.08,
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 21),
      );

      expect(settings.calculateWithTax(100), 108.0);
    });
  });

  group('ShopDaySetting', () {
    test('should format times correctly', () {
      final daySetting = ShopDaySetting(
        dayOfWeek: 1,
        startTimeMinutes: 540, // 9:00 AM
        endTimeMinutes: 1080, // 6:00 PM
      );

      expect(daySetting.startTimeFormatted, '09:00');
      expect(daySetting.endTimeFormatted, '18:00');
    });
  });

  group('QuoteInput and QuoteEstimate', () {
    test('QuoteInput should serialize to JSON', () {
      final input = QuoteInput(
        artistId: 1,
        placement: 'Forearm',
        width: 10,
        height: 5,
        isCoverUp: true,
      );

      final json = input.toJson();
      final restored = QuoteInput.fromJson(json);

      expect(restored.placement, 'Forearm');
      expect(restored.isCoverUp, true);
    });

    test('QuoteEstimate should serialize to JSON', () {
      final estimate = QuoteEstimate(
        estimatedHoursLow: 2.5,
        estimatedHoursHigh: 4.0,
        priceLow: 375,
        priceHigh: 600,
        shopMinimum: 100,
        recommendedDeposit: 75,
        confidenceScore: 0.85,
        similarJobsCount: 12,
      );

      final json = estimate.toJson();
      final restored = QuoteEstimate.fromJson(json);

      expect(restored.estimatedHoursLow, 2.5);
      expect(restored.confidenceScore, 0.85);
    });
  });
}
