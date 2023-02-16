import 'dart:async';

void main(List<String> args) async {
  await nonBroadCastStream();
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
