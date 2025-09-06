import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_native_communication_method_channel.dart';

abstract class FlutterNativeCommunicationPlatform extends PlatformInterface {
  /// Constructs a FlutterNativeCommunicationPlatform.
  FlutterNativeCommunicationPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativeCommunicationPlatform _instance = MethodChannelFlutterNativeCommunication();

  /// The default instance of [FlutterNativeCommunicationPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNativeCommunication].
  static FlutterNativeCommunicationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativeCommunicationPlatform] when
  /// they register themselves.
  static set instance(FlutterNativeCommunicationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
