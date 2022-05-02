import 'package:dicoding_bfaf_submission/data/api/api_service.dart';
import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:dicoding_bfaf_submission/util/result_state.dart';
import 'package:flutter/material.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  late List<Restaurant> _restaurant;
  late ResultState _state;

  String _message = '';

  String get message => _message;

  List<Restaurant> get result => _restaurant;

  ResultState? get state => _state;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      _message = 'Loading data';
      notifyListeners();
      final restaurant = await apiService.getList();

      if (restaurant.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Something problem and Try again later\n\n$e';
    }
  }
}
