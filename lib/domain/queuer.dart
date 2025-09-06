import '../presentation/bloc/entrypoint_bloc.dart';

/// This mixin implements the method from EntrypointQueuer, as this is shared across all
/// implementations of this BLoC paradigm when we expose the parent BLoC to children
mixin EntrypointQueuerImpl<I> on EntrypointBloc<I> {
  @override
  queueEvent({required EntrypointEvent event}) {
    add(event);
  }
}
