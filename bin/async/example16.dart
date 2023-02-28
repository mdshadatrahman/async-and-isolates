import 'dart:async';

void main(List<String> args) async {}

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
