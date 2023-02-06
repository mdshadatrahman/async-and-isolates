void main(List<String> arguments) async {
  print(await getUserName());
  print(await getAddress());
  print(await getPhoneNumber());
  print(await getCity());
}

Future<String> getUserName() async => 'John Doe';
Future<String> getAddress() => Future.value('123 Main St');
Future<String> getPhoneNumber() => Future.delayed(
      const Duration(seconds: 1),
      () => '555-555-5555',
    );
Future<String> getCity() => Future.delayed(const Duration(seconds: 1)).then((value) => 'New York');
