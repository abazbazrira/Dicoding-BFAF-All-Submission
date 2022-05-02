import 'package:dicoding_bfaf_submission/data/api/api_service.dart';
import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:dicoding_bfaf_submission/util/result_state.dart';
import 'package:flutter/material.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({
    required this.apiService,
  });

  late List<Restaurant> _restaurant;
  ResultState? _state;

  String _message = 'Find your favorite restaurant!';
  String get message => _message;

  List<Restaurant> get result => _restaurant;
  ResultState? get state => _state;

  Future<dynamic> fetchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      _message = 'Loading data';
      notifyListeners();
      if (query != '') {
        final restaurant = await apiService.getSearch(query);

        if (restaurant.isEmpty) {
          _state = ResultState.noData;
          _message = 'Empty Data';
          notifyListeners();
        } else {
          _state = ResultState.hasData;
          _restaurant = restaurant;
          notifyListeners();
        }
      } else {
        _state = ResultState.noData;
        _message = 'Find your favorite restaurant!';
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Something problem and Try again later\n\n$e';
      notifyListeners();
    }
  }
}