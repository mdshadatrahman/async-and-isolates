void main(List<String> args) async {
  // await for (final name in getNames()) {
  //   print(await extractCharacters(name));
  // }

  final result = await getNames().asyncMap((name) => extractCharacters(name)).fold('', (previous, element) {
    final elements = element.join(' ');
    return '$previous $elements ';
  });

  print(result);
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Jane';
  yield 'Jill';
}

Future<List<String>> extractCharacters(String from) async {
  final characters = <String>[];
  for (final character in from.split('')) {
    await Future.delayed(const Duration(milliseconds: 100));
    characters.add(character);
  }
  return characters;
}
