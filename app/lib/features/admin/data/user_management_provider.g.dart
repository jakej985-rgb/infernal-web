// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_management_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userManagementService)
final userManagementServiceProvider = UserManagementServiceProvider._();

final class UserManagementServiceProvider
    extends
        $FunctionalProvider<
          UserManagementService,
          UserManagementService,
          UserManagementService
        >
    with $Provider<UserManagementService> {
  UserManagementServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userManagementServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userManagementServiceHash();

  @$internal
  @override
  $ProviderElement<UserManagementService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserManagementService create(Ref ref) {
    return userManagementService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserManagementService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserManagementService>(value),
    );
  }
}

String _$userManagementServiceHash() =>
    r'0fbca476f9151b8a02b8019797470f04453c1fdc';
