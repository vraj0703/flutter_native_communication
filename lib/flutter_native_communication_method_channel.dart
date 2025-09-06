import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_native_communication_platform_interface.dart';

/// An implementation of [FlutterNativeCommunicationPlatform] that uses method channels.
class MethodChannelFlutterNativeCommunication extends FlutterNativeCommunicationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_communication');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
