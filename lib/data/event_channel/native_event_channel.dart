import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_native_communication/data/typedefs.dart';
import 'package:my_logger_metrics/logger.dart';
import 'package:flutter_native_communication/data/queuer/entrypoint_queuer.dart';
import 'package:flutter_native_communication/presentation/bloc/entrypoint_bloc.dart';

/// the properties of the NativeEventChannel
/// any logical unit can subscribe to listen the events sent from native,
/// on the provided by event channel define in "namedParameterEventChannelStream".
/// as design is based on pub/sub,
/// this channel handler is the publisher,
/// which keep track of all its subscriber in a map.
/// Subscriber responsibility is to add and delete itself.
/// The foundation data structure is a map of subscriptionKeys with
/// with list of pairs (map) of eventName and a callback to be called
/// when this particular event is invoke from the native.
/// When subscriber subscribes this publisher it provides
/// subscriptionKey and map of events name with the callback.
/// and to unsubscribe only subscriptionKey is needed.
/// When any particular event is called from native on the provided
/// event channel, the publisher loop through all the subscribers
/// to filter out the callbacks based on the event name and
/// inform the concern subscribers by calling these callbacks.
/// A callback function that takes a dynamic argument and returns void.
class NativeEventChannel {
  late final Stream<String> _stream;

  final Map<String, Map<String, NativeEventCallback>>
  _subscriberMappedCallback = {};

  NativeEventChannel({Stream<String>? stream}) {
    if (stream != null) {
      _stream = stream;
    }
  }

  StreamSubscription? _subscription;

  void startListening() {
    _subscription = _stream.listen((event) {
      try {
        _eventCall(json.decode(event));
      } catch (e, stackTrace) {
        logger.e(
          'Error processing event from native: $e',
          stackTrace: stackTrace,
        );
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
    _subscriberMappedCallback.clear();
  }

  subscribes({
    required String subscriptionKey,
    required Map<String, NativeEventCallback> callbacks,
  }) {
    logger.d('$subscriptionKey subscribe ${runtimeType.toString()}');

    _subscriberMappedCallback[subscriptionKey] = callbacks;
  }

  unsubscribe(String subscriptionKey) {
    logger.d(' $subscriptionKey unsubscribe ${runtimeType.toString()}');
    _subscriberMappedCallback.remove(subscriptionKey);
  }

  /// When native invokes the event,
  /// this function loop through all the subscription,
  /// and filter out the particular events called by the native,
  /// and call the callback associated with it.
  _eventCall(Map<String, dynamic> events) {
    for (var subscriber in _subscriberMappedCallback.values) {
      Set.from(subscriber.keys).intersection(Set.from(events.keys)).forEach((
        e,
      ) {
        subscriber[e]?.call(events[e]);
      });
    }
  }
}

class EntrypointChannelHandler {
  final MethodChannel methodChannel;
  final EntrypointQueuer queuer;

  EntrypointChannelHandler({required this.methodChannel, required this.queuer});

  static const String _startArgument = 'startFlutterScreen';

  startListening() {
    logger.d("start listening to native");
    logger.d("method channel ${methodChannel.name}");
    logger.d("method name $_startArgument");
    methodChannel.setMethodCallHandler((call) {
      logger.d("native call method name $_startArgument");
      logger.d("with arguments ${call.arguments}");

      switch (call.method) {
        case _startArgument:
          return queuer.queueEvent(
            event: EntrypointNative(args: call.arguments),
          );

        default:
          return queuer.queueEvent(
            event: EntrypointNativeCallsFlutter(
              methodName: call.method,
              args: call.arguments,
            ),
          );
      }
    });
  }

  dispose() {
    methodChannel.setMethodCallHandler(null);
  }
}
