import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/cache/id_mapper.dart';
import '../../../shared/domain/enums.dart';
import '../../../shared/domain/user.dart';
import '../../../shared/util/api_client.dart';
import '../../../shared/util/secure_storage.dart';
import '../../../shared/util/shared_prefs_provider.dart';
import 'auth_state.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  @override
  FutureOr<AuthState> build() async {
    final secureStorage = ref.watch(secureStorageProvider);
    final token = await secureStorage.readToken();

    if (token != null && token.isNotEmpty) {
      try {
        final dio = ref.watch(apiClientProvider);
        final response = await dio.get('/auth/me');
        final data = response.data as Map<String, dynamic>;
        final user = _mapProfileToUser(data);
        return AuthState.authenticated(user);
      } catch (e) {
        // Clean up invalid/expired session
        await secureStorage.deleteToken();
        final prefs = ref.watch(sharedPreferencesProvider);
        await prefs.remove('auth_jwt_token');
        return const AuthState.unauthenticated();
      }
    }
    return const AuthState.unauthenticated();
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final dio = ref.read(apiClientProvider);
      final payload = {
        'email': username,
        'password': password,
      };

      final response = await dio.post('/auth/login', data: payload);
      final token = (response.data as Map<String, dynamic>)['token'] as String;

      // Save token to secure storage and shared preferences
      final secureStorage = ref.read(secureStorageProvider);
      await secureStorage.writeToken(token);
      
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.setString('auth_jwt_token', token);

      // Fetch user profile info
      final meResponse = await dio.get('/auth/me', options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ));
      final userData = meResponse.data as Map<String, dynamic>;
      final user = _mapProfileToUser(userData);

      state = AsyncValue.data(AuthState.authenticated(user));
    } on DioException catch (e) {
      String msg = 'Login failed. Please check your credentials.';
      final responseData = e.response?.data;
      if (responseData is Map && responseData.containsKey('error')) {
        msg = responseData['error'].toString();
      }
      state = AsyncValue.data(AuthState.error(msg));
    } catch (e) {
      state = AsyncValue.data(AuthState.error(e.toString()));
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.data(AuthState.loading());
    try {
      final secureStorage = ref.read(secureStorageProvider);
      await secureStorage.deleteToken();
      
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.remove('auth_jwt_token');
      state = const AsyncValue.data(AuthState.unauthenticated());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> seedAdmin() async {
    // Admin is seeded in Cloud SQL directly via migrations or console, no local seed needed.
    return;
  }

  User _mapProfileToUser(Map<String, dynamic> data) {
    final email = data['email'] as String? ?? '';
    final roleStr = data['role'] as String? ?? 'artist';
    final userIdStr = data['user_id'] as String? ?? '';

    // Convert string UUID to stable int for local app UI compatibility
    var id = userIdStr.hashCode & 0x7FFFFFFF;
    if (id == 0) id = 1;

    // Trigger asynchronous mapping cache update
    ref.read(idMapperProvider).registerUuid('user', userIdStr);

    return User(
      id: id,
      username: email,
      displayName: email.split('@').first,
      passwordHash: '',
      role: UserRole.values.firstWhere(
        (e) => e.name.toLowerCase() == roleStr.toLowerCase(),
        orElse: () => UserRole.artist,
      ),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
