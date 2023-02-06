void main() async {
  print(await getFullName().then((value) => getLength(value)));
  print(await getLength(await getFullName()));
}

Future<String> getFullName() => Future.delayed(
      const Duration(seconds: 1),
      () => 'Shadat Rahman',
    );

Future<int> getLength(String value) => Future.delayed(
      const Duration(seconds: 1),
      () => value.length,
    );
