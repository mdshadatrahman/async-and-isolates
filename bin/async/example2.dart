void main() async {
  try {
    print(
      await getFullName(firstName: 'Shadat', lastName: 'Rahman'),
    );
    print(
      await getFullName(firstName: 'Shadat', lastName: ''),
    );
  } on FirstOrLastNameMissingException catch (e) {
    print('First or last name is missing');
  }
}

Future<String> getFullName({
  required String firstName,
  required String lastName,
}) {
  if (firstName.isEmpty || lastName.isEmpty) {
    throw FirstOrLastNameMissingException();
  } else {
    return Future.value('$firstName $lastName');
  }
}

class FirstOrLastNameMissingException implements Exception {
  const FirstOrLastNameMissingException();
}
