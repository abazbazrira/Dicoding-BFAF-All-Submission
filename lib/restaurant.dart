import 'dart:convert';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late Menu menu;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menu,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'];
    menu = Menu.fromJson(restaurant['menus']);
  }
}

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

class Food {
  late String name;

  Food({
    required this.name,
  });

  Food.fromJson(Map<String, dynamic> food) {
    name = food['name'];
  }
}

class Drink {
  late String name;

  Drink({
    required this.name,
  });

  Drink.fromJson(Map<String, dynamic> drink) {
    name = drink['name'];
  }
}

List<Restaurant> parseRestaurants(dynamic json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
