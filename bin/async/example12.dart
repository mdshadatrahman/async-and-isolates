//Error handling on Stream

import 'dart:async';

void main(List<String> args) async {
  await for (final name in getNames().absorbErrorsUsingTranformer()) {
    print(name);
  }
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Jane';
  throw 'All out of names';
}

extension AbsorbErrors<T> on Stream<T> {
  Stream<T> absorbErrorsUsingHandleError() => handleError(
        (_, __) {},
      );

  Stream<T> absorbErrorsUsingHandlers() => transform(
        StreamTransformer.fromHandlers(
          handleError: (_, __, sink) => sink.close(),
        ),
      );

  Stream<T> absorbErrorsUsingTranformer() => transform(
        StreamErrorAbsorber(),
      );
}

class StreamErrorAbsorber<T> extends StreamTransformerBase<T, T> {
  @override
  Stream<T> bind(Stream<T> stream) {
    final controller = StreamController<T>();
    stream.listen(
      controller.sink.add,
      onError: (_) {},
      onDone: controller.close,
    );
    return controller.stream;
  }
}
