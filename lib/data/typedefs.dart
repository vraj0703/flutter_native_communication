import 'package:flutter/material.dart';

typedef NativeEventCallback = void Function(String args);
typedef EntrypointWidgetBuilder<I> =
    Widget Function(BuildContext context, I? input);
