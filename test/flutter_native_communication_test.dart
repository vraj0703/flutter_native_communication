import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_communication/flutter_native_communication.dart';
import 'package:flutter_native_communication/flutter_native_communication_platform_interface.dart';
import 'package:flutter_native_communication/flutter_native_communication_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNativeCommunicationPlatform
    with MockPlatformInterfaceMixin
    implements FlutterNativeCommunicationPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterNativeCommunicationPlatform initialPlatform = FlutterNativeCommunicationPlatform.instance;

  test('$MethodChannelFlutterNativeCommunication is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterNativeCommunication>());
  });

  test('getPlatformVersion', () async {
    FlutterNativeCommunication flutterNativeCommunicationPlugin = FlutterNativeCommunication();
    MockFlutterNativeCommunicationPlatform fakePlatform = MockFlutterNativeCommunicationPlatform();
    FlutterNativeCommunicationPlatform.instance = fakePlatform;

    expect(await flutterNativeCommunicationPlugin.getPlatformVersion(), '42');
  });
}
