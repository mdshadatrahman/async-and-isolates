import 'dart:async';

void main(List<String> args) async {
  // await nonBroadCastStream();
  await broadCastStream();
}

Future<void> nonBroadCastStream() async {
  final controller = StreamController();

  controller.sink.add('Bob');
  controller.sink.add('Jack');
  controller.sink.add('Jill');

  try {
    await for (final name in controller.stream) {
      print(name);
      await for (final name2 in controller.stream) {
        print(name2);
      }
    }
  } catch (e) {
    print(e);
  }
}

Future<void> broadCastStream() async {
  late final StreamController<String> controller;

  controller = StreamController<String>.broadcast();

  final sub1 = controller.stream.listen((name) {
    print('sub1: $name');
  });

  final sub2 = controller.stream.listen((name) {
    print('sub2: $name');
  });

  controller.sink.add('Bob');
  controller.sink.add('Jack');
  controller.sink.add('Jill');

  controller.onCancel = () {
    sub1.cancel();
    sub2.cancel();
    print('onCancel');
  };
}
