import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_communication/data/typedefs.dart';
import 'package:my_logger_metrics/logger.dart';
import 'package:flutter_native_communication/presentation/bloc/entrypoint_bloc.dart';

class EntrypointBasePage<I> extends StatelessWidget {
  final EntrypointWidgetBuilder<I> builder;

  const EntrypointBasePage({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntrypointBloc, EntrypointState>(
      builder: (ctx, state) {
        logger.d("EntrypointBloc state changed $state");
        if (state is EntrypointLoaded) {
          return builder(context, state.args);
        } else if (state is EntrypointExternalNavigationFailed) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }
}
