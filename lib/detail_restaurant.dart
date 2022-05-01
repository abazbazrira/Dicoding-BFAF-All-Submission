import 'package:dicoding_bfaf_submission/restaurant.dart';
import 'package:flutter/material.dart';

class DetailRestaurantPage extends StatelessWidget {
  const DetailRestaurantPage({required this.restaurant});

  static const routeName = '/detail_restaurant';

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: restaurant.pictureId,
              child: Image.network(restaurant.pictureId),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText1,
                        children: [
                          TextSpan(
                            text: restaurant.rating.toString(),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Icon(
                                Icons.star,
                                size: 20,
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 6.0, right: 6.0),
                              child: Text(
                                '-',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: restaurant.city,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 36.0, bottom: 8.0),
                    child: Text(
                      'Foods',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: restaurant.menu.foods.map((food) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 4.0, top: 4.0, left: 16.0),
                        child: Text(
                          food.name,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0, bottom: 8.0),
                    child: Text(
                      'Drinks',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: restaurant.menu.drinks.map((drink) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 4.0, top: 4.0, left: 16.0),
                        child: Text(
                          drink.name,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
