import 'package:dicoding_bfaf_submission/data/api/api_service.dart';
import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:dicoding_bfaf_submission/provider/detail_restaurant_provider.dart';
import 'package:dicoding_bfaf_submission/util/result_state.dart';
import 'package:dicoding_bfaf_submission/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailRestaurantPage extends StatelessWidget {
  static const routeName = '/detail_restaurant';
  final String title = 'Restaurant';
  final Restaurant restaurant;

  const DetailRestaurantPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(
        apiService: ApiService(),
        restaurantId: restaurant.id,
      ),
      child: PlatformWidget(
        androidBuilder: _androidBuilder(context),
        iosBuilder: _iosBuilder(context),
      ),
    );
  }

  Widget _buildDetail(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, value, child) {
        if (value.state == ResultState.loading) {
          return Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircularProgressIndicator(
                  color: Colors.black,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Text(value.message),
                ),
              ],
            ),
          );
        } else if (value.state == ResultState.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: value.result.pictureId,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/small/${value.result.pictureId}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        value.result.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText1,
                            children: [
                              TextSpan(
                                text: value.result.rating.toString(),
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
                                  padding: const EdgeInsets.only(
                                      left: 6.0, right: 6.0),
                                  child: Text(
                                    '-',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: value.result.city,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 8.0),
                      //   child: Text(value.result.categories.map((e) => e.name).toString()),
                      // ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        value.result.description,
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
                        children: value.result.menu!.foods.map((food) {
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
                        children: value.result.menu!.drinks.map((drink) {
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
          );
        } else if (value.state == ResultState.noData) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Text(
                value.message,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (value.state == ResultState.error) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Center(
              child: Text(
                value.message,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'Something problem. Try again later.',
              textAlign: TextAlign.center,
            ),
          );
        }
      },
    );
  }

  Widget _androidBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: _buildDetail(context),
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Text(
          title,
        ),
      ),
      child: _buildDetail(context),
    );
  }
}
