import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_communication/data/event_channel/native_event_channel.dart';
import 'package:flutter_native_communication/data/queuer/entrypoint_queuer.dart';
import 'package:my_logger_metrics/logger.dart';

part 'entrypoint_event.dart';

part 'entrypoint_state.dart';

/// Entrypoint BLoC can be implemented by the new screens
/// This bloc empowers the implemented route to be open from native
/// as well as internally.
/// Rather than creating a stateful widget and manually parsing out arguments
/// passed from native for every screen,

/// developers need only to do
/// - define the <I> input type for the route
/// - create a class that implements 1 method

/// Method 1: externalStart
/// The returned event will hold the arguments from the method, of type dynamic
/// Parse the dictionary as you please and extract the information you needed
/// If data is missing, emit EntrypointBadData
/// If all the data is there, emit EntrypointLoaded with an object of <I>
abstract class EntrypointBloc<I> extends Bloc<EntrypointEvent, EntrypointState>
    implements EntrypointQueuer {
  final String channelName;
  late final EntrypointChannelHandler _channelHandler;

  FutureOr<void> externalStart(
    EntrypointNative event,
    Emitter<EntrypointState> emit,
  );

  FutureOr<void> nativeCallsFlutter(EntrypointNativeCallsFlutter event) {
    // override as per need
  }

  EntrypointBloc(super.initialState, this.channelName) {
    logger.d("EntrypointBloc init channel handler");
    logger.d("channel name $channelName");
    _channelHandler = EntrypointChannelHandler(
      methodChannel: MethodChannel(channelName),
      queuer: this,
    );

    _channelHandler.startListening();

    on<EntrypointNative>(externalStart);
    on<EntrypointInternal>(_internalStart);
    on<EntrypointMethodCall>(_nativeMethodCall);
    on<EntrypointNativeCallsFlutter>(_nativeCallsFlutter);
  }

  FutureOr<void> _internalStart(
    EntrypointInternal event,
    Emitter<EntrypointState> emit,
  ) {
    logger.d("EntrypointInternal received in EntrypointBloc");
    emit(EntrypointLoaded<I>(event.args));
    logger.d("emit state EntrypointLoaded with input ${event.args}");
  }

  FutureOr<void> _nativeMethodCall(
    EntrypointMethodCall event,
    Emitter<EntrypointState> emit,
  ) {
    _channelHandler.methodChannel.invokeMethod(
      event.methodName,
      event.arguments,
    );
  }

  FutureOr<void> _nativeCallsFlutter(
    EntrypointNativeCallsFlutter event,
    Emitter<EntrypointState> emit,
  ) {
    nativeCallsFlutter(event);
  }

  @override
  Future<void> close() {
    _channelHandler.dispose();
    return super.close();
  }
}
