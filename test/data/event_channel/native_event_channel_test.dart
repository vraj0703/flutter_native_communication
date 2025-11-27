import 'dart:async';

import 'dart:convert';

import 'package:flutter_native_communication/data/event_channel/native_event_channel.dart';
import 'package:flutter_native_communication/data/typedefs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NativeEventChannel nativeEventChannel;
  late StreamController<String> streamController;

  setUp(() {
    streamController = StreamController<String>();
    nativeEventChannel = NativeEventChannel(stream: streamController.stream);
    nativeEventChannel.startListening();
  });

  tearDown(() {
    nativeEventChannel.dispose();
    streamController.close();
  });

  test('should invoke callback when event is received', () async {
    bool callbackCalled = false;
    final Map<String, NativeEventCallback> callbacks = {
      'testEvent': (args) {
        callbackCalled = true;
        expect(args, 'testData');
      },
    };

    nativeEventChannel.subscribes(
      subscriptionKey: 'testKey',
      callbacks: callbacks,
    );

    // Simulate native event
    streamController.add(json.encode({'testEvent': 'testData'}));

    // Wait for stream to process
    await Future.delayed(Duration.zero);

    expect(callbackCalled, isTrue);
  });

  test('should not invoke callback after unsubscribe', () async {
    bool callbackCalled = false;
    final Map<String, NativeEventCallback> callbacks = {
      'testEvent': (args) {
        callbackCalled = true;
      },
    };

    nativeEventChannel.subscribes(
      subscriptionKey: 'testKey',
      callbacks: callbacks,
    );
    nativeEventChannel.unsubscribe('testKey');

    // Simulate native event
    streamController.add(json.encode({'testEvent': 'testData'}));

    // Wait for stream to process
    await Future.delayed(Duration.zero);

    expect(callbackCalled, isFalse);
  });
}
