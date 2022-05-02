import 'package:dicoding_bfaf_submission/data/api/api_service.dart';
import 'package:dicoding_bfaf_submission/provider/search_restaurant_provider.dart';
import 'package:dicoding_bfaf_submission/util/result_state.dart';
import 'package:dicoding_bfaf_submission/widget/item_restaurant.dart';
import 'package:dicoding_bfaf_submission/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchRestaurant extends StatefulWidget {
  static const routeName = '/search_restaurant';

  const SearchRestaurant({Key? key}) : super(key: key);

  @override
  _SearchRestaurantState createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  final String title = 'Restaurant';
  String query = '';
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchRestaurantProvider(
        apiService: ApiService(),
      ),
      child: PlatformWidget(
        androidBuilder: _androidBuilder(context),
        iosBuilder: _iosBuilder(context),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, value, _) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 24,
              ),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Find the restaurant by name, category or menu',
                ),
                onChanged: (String s) {
                  setState(() {
                    query = s;
                    value.fetchRestaurants(query);
                  });
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: _buildList(context),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
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
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Text(
                value.message,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return Center(
            child: Text(
              value.message,
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
      body: _buildSearch(context),
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Text(
          title,
        ),
      ),
      child: _buildSearch(context),
    );
  }
}
