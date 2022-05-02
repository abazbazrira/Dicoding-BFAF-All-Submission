import 'package:dicoding_bfaf_submission/data/model/drink.dart';
import 'package:dicoding_bfaf_submission/data/model/food.dart';

class Menu {
  late List<Food> foods;
  late List<Drink> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  Menu.fromJson(Map<String, dynamic> menu) {
    if (menu['foods'] != null) {
      foods = List<Food>.from(menu['foods'].map((x) => Food.fromJson(x)));
    }

    if (menu['drinks'] != null) {
      drinks = List<Drink>.from(menu['drinks'].map((x) => Drink.fromJson(x)));
    }
  }
}
