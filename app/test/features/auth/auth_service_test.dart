import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:infernal_ink_steel/features/auth/data/user_repository.dart';
import 'package:infernal_ink_steel/features/auth/domain/auth_service.dart';
import 'package:infernal_ink_steel/features/auth/domain/auth_state.dart';
import 'package:infernal_ink_steel/shared/domain/user.dart';
import 'package:infernal_ink_steel/shared/domain/enums.dart';
import 'package:infernal_ink_steel/shared/util/shared_prefs_provider.dart';

import 'package:bcrypt/bcrypt.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockUserRepository mockUserRepository;
  late MockSharedPreferences mockSharedPreferences;
  late ProviderContainer container;

  final testUser = User(
    id: 1,
    username: 'testuser',
    displayName: 'Test User',
    passwordHash: BCrypt.hashpw('password', BCrypt.gensalt()),
    role: UserRole.artist,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockSharedPreferences = MockSharedPreferences();
    container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWith((ref) => mockUserRepository),
        sharedPreferencesProvider.overrideWithValue(mockSharedPreferences),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'AuthService initializes with unauthenticated state if no session exists',
    () async {
      when(() => mockSharedPreferences.getInt(any())).thenReturn(null);

      // Trigger build
      final state = await container.read(authServiceProvider.future);

      expect(state, const AuthState.unauthenticated());
    },
  );

  test('AuthService restores session if user ID exists in prefs', () async {
    when(() => mockSharedPreferences.getInt('user_session_id')).thenReturn(1);
    when(
      () => mockUserRepository.getUserById(1),
    ).thenAnswer((_) async => testUser);

    // Initial read triggers build
    final state = await container.read(authServiceProvider.future);

    expect(state, AuthState.authenticated(testUser));
    verify(() => mockUserRepository.getUserById(1)).called(1);
  });

  test('login succeeds with correct credentials', () async {
    when(
      () => mockSharedPreferences.getInt(any()),
    ).thenReturn(null); // Initial state
    when(
      () => mockUserRepository.getUserByUsername('testuser'),
    ).thenAnswer((_) async => testUser);
    when(
      () => mockSharedPreferences.setInt('user_session_id', 1),
    ).thenAnswer((_) async => true);

    final descriptor = authServiceProvider;
    final notifier = container.read(descriptor.notifier);

    // Ensure build is done
    await container.read(descriptor.future);

    await notifier.login('testuser', 'password');

    final state = container.read(descriptor);
    expect(state.value, AuthState.authenticated(testUser));
    verify(() => mockSharedPreferences.setInt('user_session_id', 1)).called(1);
  });

  test('login fails with incorrect password', () async {
    when(() => mockSharedPreferences.getInt(any())).thenReturn(null);
    when(
      () => mockUserRepository.getUserByUsername('testuser'),
    ).thenAnswer((_) async => testUser);

    final descriptor = authServiceProvider;
    final notifier = container.read(descriptor.notifier);
    await container.read(descriptor.future);

    await notifier.login('testuser', 'wrongpassword');

    final state = container.read(descriptor);
    expect(state.value, const AuthState.error('Invalid credentials'));
    // Or check specific message if needed
    state.value!.mapOrNull(
      error: (e) => expect(e.message, 'Invalid credentials'),
    );
  });

  test('logout clears session', () async {
    when(() => mockSharedPreferences.getInt(any())).thenReturn(1);
    when(
      () => mockUserRepository.getUserById(1),
    ).thenAnswer((_) async => testUser);
    when(
      () => mockSharedPreferences.remove('user_session_id'),
    ).thenAnswer((_) async => true);

    final descriptor = authServiceProvider;
    final notifier = container.read(descriptor.notifier);

    // Restore session
    await container.read(descriptor.future);

    await notifier.logout();

    final state = container.read(descriptor);
    expect(state.value, const AuthState.unauthenticated());
    verify(() => mockSharedPreferences.remove('user_session_id')).called(1);
  });
}
