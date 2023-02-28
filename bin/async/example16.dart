import 'dart:async';

void main(List<String> args) async {
  try {
    await for (final name in getNames().withTimeoutBetweenEvents(const Duration(seconds: 3))) {
      print(name);
    }
  } on TimeOutBetweenEventsException catch (e, stackTrace) {
    print('TimeoutBetweenEventsException: $e');
    print('Stack Trace: $stackTrace');
  }
}

Stream<String> getNames() async* {
  yield 'John';
  await Future.delayed(const Duration(seconds: 1));
  yield 'Jane';
  await Future.delayed(const Duration(seconds: 10));
  yield 'Doe';
}

extension WithTimeoutBetweenEvents<T> on Stream<T> {
  Stream<T> withTimeoutBetweenEvents(Duration duration) => transform(
        TimeoutBetweenEvents(duration: duration),
      );
}

class TimeoutBetweenEvents<E> extends StreamTransformerBase<E, E> {
  final Duration duration;
  const TimeoutBetweenEvents({required this.duration});
  @override
  Stream<E> bind(Stream<E> stream) {
    StreamController<E>? controller;
    StreamSubscription<E>? subscription;
    Timer? timer;

    controller = StreamController(
      onListen: () {
        subscription = stream.listen(
          (data) {
            timer?.cancel();
            timer = Timer.periodic(
              duration,
              (timer) {
                controller?.addError(TimeOutBetweenEventsException('TimeOut'));
              },
            );
            controller?.add(data);
          },
          onError: controller?.addError,
          onDone: controller?.close,
        );
      },
      onCancel: () {
        timer!.cancel();
        subscription!.cancel();
      },
    );
    return controller.stream;
  }
}

class TimeOutBetweenEventsException implements Exception {
  final String message;
  TimeOutBetweenEventsException(this.message);
}
