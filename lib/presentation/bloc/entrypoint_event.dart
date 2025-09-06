part of 'entrypoint_bloc.dart';

abstract class EntrypointEvent extends Equatable {
  const EntrypointEvent();

  @override
  List<Object> get props => [];
}

class EntrypointNative extends EntrypointEvent {
  final dynamic args;

  const EntrypointNative({required this.args});

  @override
  List<Object> get props => [args.hashCode];
}

class EntrypointMethodCall extends EntrypointEvent {
  final String methodName;
  final dynamic arguments;

  const EntrypointMethodCall({
    required this.methodName,
    required this.arguments,
  });

  @override
  List<Object> get props => [methodName.hashCode, arguments.hashCode];
}

class EntrypointInternal<I> extends EntrypointEvent {
  final I args;

  const EntrypointInternal({required this.args});

  @override
  List<Object> get props => [args.hashCode];
}

class EntrypointNativeCallsFlutter extends EntrypointEvent {
  final String methodName;
  final dynamic args;

  const EntrypointNativeCallsFlutter({
    required this.methodName,
    required this.args,
  });

  @override
  List<Object> get props => [args.hashCode];
}
