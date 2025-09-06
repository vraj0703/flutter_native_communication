import 'package:flutter_native_communication/presentation/bloc/entrypoint_bloc.dart';

/// EntrypointQueuer exposes a single method so that children that aren't part of the Widget tree
/// can queue events to the BLoC. In this scenario, it is the ChannelHandler class
abstract class EntrypointQueuer {
  queueEvent({required EntrypointEvent event});
}
