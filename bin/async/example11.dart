void main(List<String> args) async {
  final names = await getNames().toList();
  print(names);
}

Stream getNames() async* {
  yield 'First Name';
  yield 'Last Name';
  yield 'Optional';
}
