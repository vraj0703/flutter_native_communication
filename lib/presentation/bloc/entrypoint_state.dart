part of 'entrypoint_bloc.dart';

abstract class EntrypointState extends Equatable {
  const EntrypointState();

  @override
  List<Object> get props => [];
}

class EntrypointWaiting extends EntrypointState {}

class EntrypointLoaded<I> extends EntrypointState {
  final I args;

  const EntrypointLoaded(this.args);

  @override
  List<Object> get props => [args as Object];
}

class EntrypointExternalNavigationFailed extends EntrypointState {
  final String reason;

  const EntrypointExternalNavigationFailed({required this.reason});

  @override
  List<Object> get props => [reason];
}

class EntrypointInitial extends EntrypointState {}

class EntrypointBadData extends EntrypointState {}
