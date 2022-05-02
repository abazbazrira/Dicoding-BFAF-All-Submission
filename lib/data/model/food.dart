class Food {
  late String name;

  Food({
    required this.name,
  });

  Food.fromJson(Map<String, dynamic> food) {
    name = food['name'];
  }
}
