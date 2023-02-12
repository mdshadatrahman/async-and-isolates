void main(List<String> args) async {
  await for (final character in getNames().asyncExpand((event) => getCharacters(event))) {
    print(character);
  }

  await for (final character in getCharacters('fromString')) {
    print(character);
  }
}

Stream<String> getCharacters(String fromString) async* {
  for (var i = 0; i < fromString.length; i++) {
    await Future.delayed(const Duration(milliseconds: 300));
    yield fromString[i];
  }
}

Stream<String> getNames() async* {
  await Future.delayed(const Duration(milliseconds: 200));
  yield 'John';
  await Future.delayed(const Duration(milliseconds: 300));
  yield 'Doe';
}
