class Drink {
  late String name;

  Drink({
    required this.name,
  });

  Drink.fromJson(Map<String, dynamic> drink) {
    name = drink['name'];
  }
}
