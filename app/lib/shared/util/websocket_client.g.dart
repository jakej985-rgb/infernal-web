// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WebSocketClient)
final webSocketClientProvider = WebSocketClientProvider._();

final class WebSocketClientProvider
    extends $StreamNotifierProvider<WebSocketClient, Map<String, dynamic>> {
  WebSocketClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSocketClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSocketClientHash();

  @$internal
  @override
  WebSocketClient create() => WebSocketClient();
}

String _$webSocketClientHash() => r'bc7510b78c43dc5def075b0462098656bb6e8dfe';

abstract class _$WebSocketClient extends $StreamNotifier<Map<String, dynamic>> {
  Stream<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>>,
                Map<String, dynamic>
              >,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
