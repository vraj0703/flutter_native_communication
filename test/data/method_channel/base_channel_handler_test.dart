import 'package:flutter/services.dart';
import 'package:flutter_native_communication/data/method_channel/base_channel_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late BaseChannelHandler handler;
  const String channelName = 'test_channel';
  const MethodChannel channel = MethodChannel(channelName);

  setUp(() {
    handler = BaseChannelHandler(channelName);
    handler.startListening();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('should invoke callback when method is called', () async {
    bool callbackCalled = false;
    final Map<String, ChannelHandlerCallback> callbacks = {
      'testMethod': (call) {
        callbackCalled = true;
      },
    };

    handler.blocSubscribes('testKey', callbacks);

    // Simulate native method call
    await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
          channelName,
          const StandardMethodCodec().encodeMethodCall(
            const MethodCall('testMethod'),
          ),
          (ByteData? data) {},
        );

    expect(callbackCalled, isTrue);
  });

  test('should not invoke callback after unsubscribe', () async {
    bool callbackCalled = false;
    final Map<String, ChannelHandlerCallback> callbacks = {
      'testMethod': (call) {
        callbackCalled = true;
      },
    };

    handler.blocSubscribes('testKey', callbacks);
    handler.blocUnsubscribe('testKey');

    // Simulate native method call
    await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
          channelName,
          const StandardMethodCodec().encodeMethodCall(
            const MethodCall('testMethod'),
          ),
          (ByteData? data) {},
        );

    expect(callbackCalled, isFalse);
  });

  test('should handle exception in callback gracefully', () async {
    final Map<String, ChannelHandlerCallback> callbacks = {
      'testMethod': (call) {
        throw Exception('Test Exception');
      },
    };

    handler.blocSubscribes('testKey', callbacks);

    // Should not crash
    await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
          channelName,
          const StandardMethodCodec().encodeMethodCall(
            const MethodCall('testMethod'),
          ),
          (ByteData? data) {},
        );
  });
}
