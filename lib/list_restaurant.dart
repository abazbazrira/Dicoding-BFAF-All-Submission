import 'package:dicoding_bfaf_submission/detail_restaurant.dart';
import 'package:dicoding_bfaf_submission/restaurant.dart';
import 'package:flutter/material.dart';

class ListRestaurantPage extends StatelessWidget {
  const ListRestaurantPage({Key? key}) : super(key: key);

  static const routeName = '/list_restaurant';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant App',
        ),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('assets/restaurants.json'),
        builder: (context, snapshot) {
          final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurants[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          restaurant.pictureId,
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
