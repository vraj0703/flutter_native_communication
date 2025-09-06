import 'flutter_native_communication_platform_interface.dart';

class FlutterNativeCommunication {
  Future<String?> getPlatformVersion() {
    return FlutterNativeCommunicationPlatform.instance.getPlatformVersion();
  }
}
