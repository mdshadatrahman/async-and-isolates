import 'dart:async';

void main(List<String> args) async {
  await for (final capitalizedName in names.capitalized) {
    print(capitalizedName);
  }
  print('-----------------------');

  await for (final capName in names.capitalizedUsingMap) {
    print(capName);
  }
}

Stream<String> names = Stream.fromIterable(
  [
    'First Name',
    'Maiden Name',
    'Last Name',
  ],
);

extension on Stream<String> {
  Stream<String> get capitalized => transform(ToUpperCase());
}

extension on Stream<String> {
  Stream<String> get capitalizedUsingMap => map((event) => event.toUpperCase());
}

class ToUpperCase extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map((event) => event.toUpperCase());
  }
}
