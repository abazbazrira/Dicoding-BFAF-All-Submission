import 'package:dicoding_bfaf_submission/ui/detail_restaurant.dart';
import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:flutter/material.dart';

class ItemRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const ItemRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: restaurant.pictureId.toString(),
        child: Image.network(
          'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
          width: 100,
        ),
      ),
      title: Text(
        restaurant.name,
      ),
      subtitle: Text(
        restaurant.description,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      onTap: () {
        Navigator.pushNamed(context, DetailRestaurantPage.routeName,
            arguments: restaurant);
      },
    );
  }
}
