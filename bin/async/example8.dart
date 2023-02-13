void main(List<String> args) async {
  await for (final value in getAllNames()) {
    print(value);
  }
}

Stream<String> maleNames() async* {
  yield 'Test1';
  yield 'Test2';
  yield 'Test3';
}

Stream<String> femaleNames() async* {
  yield 'Test4';
  yield 'Test5';
  yield 'Test6';
}

Stream<String> getAllNames() async* {
  yield* maleNames();
  yield* femaleNames();
}
