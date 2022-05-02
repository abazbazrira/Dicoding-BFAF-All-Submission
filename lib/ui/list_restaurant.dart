import 'package:dicoding_bfaf_submission/data/api/api_service.dart';
import 'package:dicoding_bfaf_submission/provider/list_restaurant_provider.dart';
import 'package:dicoding_bfaf_submission/ui/search_restaurant.dart';
import 'package:dicoding_bfaf_submission/util/result_state.dart';
import 'package:dicoding_bfaf_submission/widget/item_restaurant.dart';
import 'package:dicoding_bfaf_submission/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRestaurantPage extends StatelessWidget {
  static const routeName = '/list_restaurant';
  final String title = 'Restaurant App';

  const ListRestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListRestaurantProvider>(
      create: (_) => ListRestaurantProvider(
        apiService: ApiService(),
      ),
      child: PlatformWidget(
        androidBuilder: _androidBuilder(context),
        iosBuilder: _iosBuilder(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<ListRestaurantProvider>(
      builder: (context, value, _) {
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
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.result.length,
            itemBuilder: (context, index) {
              var restaurant = value.result[index];
              return ItemRestaurant(restaurant: restaurant);
            },
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchRestaurant.routeName);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _buildList(context),
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Text(
          title,
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SearchRestaurant.routeName);
          },
          icon: const Icon(CupertinoIcons.search),
        ),
      ),
      child: _buildList(context),
    );
  }
}
