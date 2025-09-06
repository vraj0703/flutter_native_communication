import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_communication/data/typedefs.dart';
import 'package:flutter_native_communication/data/unit_classes.dart';
import 'package:flutter_native_communication/domain/queuer.dart';
import 'package:flutter_native_communication/logger.dart';
import 'package:flutter_native_communication/presentation/bloc/entrypoint_bloc.dart';
import 'entrypoint_base_page.dart';

class EntrypointBaseInterceptor<I> extends StatelessWidget {
  final I? input;

  final EntrypointBloc<I> bloc;
  final EntrypointWidgetBuilder<I> builder;

  const EntrypointBaseInterceptor({
    super.key,
    required this.bloc,
    required this.input,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    logger.d("build EntrypointBaseInterceptor with input type $I");
    logger.d("input received $input");
    logger.d("bloc received ${bloc.runtimeType}");
    return BlocProvider<EntrypointBloc>(
      lazy: false,

      create: (ctx) {
        if (input != null) {
          /// if input is not null means
          /// app has sufficient input to build the requested page by route
          /// and EntrypointBloc won't wait from native to render ui
          /// instead EntrypointInternal event will emit loaded state with
          /// not null input
          bloc.add(EntrypointInternal(args: input));
        }

        return bloc;
      },

      child: EntrypointBasePage(builder: builder),
    );
  }
}

class HomeEntrypointImpl extends EntrypointBloc<Unit>
    with EntrypointQueuerImpl {
  HomeEntrypointImpl(super.initialState, super.channelName);

  @override
  FutureOr<void> externalStart(
    EntrypointNative event,
    Emitter<EntrypointState> emit,
  ) {
    logger.d("In HomeEntrypointImpl, emitting loaded state");
    emit(EntrypointLoaded(unit));
  }
}

/*
class HomeScreenWidget extends StatelessWidget {
  final GoRouterState state;

  const HomeScreenWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntrypointBaseInterceptor(
      input: tryCastNoFallback<None>(state.extra),

      bloc: HomeEntrypointImpl(EntrypointWaiting(), "twin.home"),

      builder: (_, __) => Container(),
    );
  }
}*/
