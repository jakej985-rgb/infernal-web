import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:drift/drift.dart' as drift;
import 'package:infernal_ink_steel/features/communications/data/communications_provider.dart';
import 'package:infernal_ink_steel/shared/persistence/daos/communications_dao.dart';
import 'package:infernal_ink_steel/shared/persistence/database.dart';

class MockCommunicationsDao extends Mock implements CommunicationsDao {}

class FakeCommunicationsTableCompanion extends Fake implements CommunicationsTableCompanion {}

void main() {
  late MockCommunicationsDao mockDao;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(FakeCommunicationsTableCompanion());
  });

  setUp(() {
    mockDao = MockCommunicationsDao();
    container = ProviderContainer(
      overrides: [
        communicationsDaoProvider.overrideWith((ref) => mockDao),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('CommunicationsService', () {
    test('sendCommunication calls Dao insert', () async {
      when(() => mockDao.insertCommunication(any())).thenAnswer((_) async => 1);

      final companion = const CommunicationsTableCompanion(
        content: drift.Value('Test message'),
      );

      await container.read(communicationsServiceProvider.notifier).sendCommunication(companion);

      verify(() => mockDao.insertCommunication(companion)).called(1);
    });

    test('deleteCommunication calls Dao delete', () async {
      when(() => mockDao.deleteCommunication(any())).thenAnswer((_) async {});

      await container.read(communicationsServiceProvider.notifier).deleteCommunication(123);

      verify(() => mockDao.deleteCommunication(123)).called(1);
    });
  });
}
