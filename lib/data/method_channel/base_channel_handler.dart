import 'package:flutter/services.dart';
import 'package:my_logger_metrics/logger.dart';

/// the properties of the BaseChannelHandler
/// any bloc can subscribe to listen the methods called from native,
/// on the provided method channel.
/// as design is based on pub/sub,
/// this channel handler is the publisher,
/// which keep track of all its subscriber in a map.
///
/// Subscriber responsibility is to add and delete itself.
/// The foundation data structure is a map of subscriptionKeys with
/// with list of pairs (map) of methodName and a callback to be called
/// when this particular methodName is called from the native.
/// When subscriber subscribes this publisher it provides
/// subscriptionKey and map of methodName with callback.
/// and to unsubscribe only subscriptionKey is needed.
///
/// When any particular method is called from native on the provided
/// method channel, the publisher loop through all the subscribers
/// to filter out the callbacks based on the method name and
/// inform the concern subscribers by calling these callbacks.
///

class BaseChannelHandler {
  final String methodChannelName;

  late final MethodChannel _methodChannel = MethodChannel(methodChannelName);

  final Map<String, Map<String, ChannelHandlerCallback>>
  _blocKeyMappedMethodCallback = {};

  BaseChannelHandler(this.methodChannelName);

  blocSubscribes(
    String subscriptionKey,

    Map<String, ChannelHandlerCallback> methodCallback,
  ) {
    logger.d('bloc subscribe $subscriptionKey');
    _blocKeyMappedMethodCallback[subscriptionKey] = methodCallback;
  }

  blocUnsubscribe(String subscriptionKey) {
    logger.d('bloc unsubscribe $subscriptionKey');
    _blocKeyMappedMethodCallback.remove(subscriptionKey);
  }

  startListening() {
    logger.d('start listening to channel $methodChannelName');
    _methodChannel.setMethodCallHandler((call) {
      logger.d('${call.method} called');
      return _methodCalled(call);
    });
  }

  _methodCalled(MethodCall call) {
    _blocKeyMappedMethodCallback.forEach((key, value) {
      var method = value[call.method];

      if (method != null) {
        try {
          method(call);
        } on Exception catch (e) {
          logger.e(
            'trying to call ${call.method} with subscription key $key but failed with $e,'
            '\n CHECK IF `blocUnsubscribe` CALLED ONCE BLOC DIES',
          );
        }
      }
    });
  }

  dispose() {
    logger.d('dispose channel $methodChannelName');
    _blocKeyMappedMethodCallback.clear();
    _methodChannel.setMethodCallHandler(null);
  }
}

typedef ChannelHandlerCallback = void Function(MethodCall call);
