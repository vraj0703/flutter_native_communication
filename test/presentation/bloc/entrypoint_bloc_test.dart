import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_communication/presentation/bloc/entrypoint_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_native_communication/domain/queuer.dart';

class TestEntrypointBloc extends EntrypointBloc<String>
    with EntrypointQueuerImpl<String> {
  TestEntrypointBloc(String channelName)
    : super(EntrypointInitial(), channelName);

  @override
  Future<void> externalStart(
    EntrypointNative event,
    Emitter<EntrypointState> emit,
  ) async {
    print('TestEntrypointBloc: externalStart received args: ${event.args}');
    if (event.args is String) {
      emit(EntrypointLoaded<String>(event.args as String));
    } else {
      emit(EntrypointBadData());
    }
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const String channelName = 'test_entrypoint_channel';
  const MethodChannel channel = MethodChannel(channelName);

  group('EntrypointBloc', () {
    late TestEntrypointBloc bloc;

    setUp(() {
      bloc = TestEntrypointBloc(channelName);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is EntrypointInitial', () {
      expect(bloc.state, isA<EntrypointInitial>());
    });

    blocTest<TestEntrypointBloc, EntrypointState>(
      'emits [EntrypointLoaded] when EntrypointInternal is added',
      build: () => bloc,
      act: (bloc) => bloc.add(const EntrypointInternal(args: 'test_data')),
      expect: () => [const EntrypointLoaded<String>('test_data')],
    );

    test('handles native start call correctly', () async {
      // Set up expectation before triggering event
      final future = expectLater(
        bloc.stream,
        emits(const EntrypointLoaded<String>('native_data')),
      );

      // Simulate native call 'startFlutterScreen'
      await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .handlePlatformMessage(
            channelName,
            const StandardMethodCodec().encodeMethodCall(
              const MethodCall('startFlutterScreen', 'native_data'),
            ),
            (ByteData? data) {},
          );

      // Wait for expectation
      await future;
    });
  });
}
