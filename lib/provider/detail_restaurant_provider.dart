import 'package:dicoding_bfaf_submission/data/api/api_service.dart';
import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:dicoding_bfaf_submission/util/result_state.dart';
import 'package:flutter/material.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  DetailRestaurantProvider(
      {required this.apiService, required this.restaurantId}) {
    _fetchRestaurant();
  }

  late Restaurant _restaurant;
  late ResultState _state;

  String _message = '';
  String get message => _message;

  Restaurant get result => _restaurant;
  ResultState? get state => _state;

  Future<dynamic> _fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      _message = 'Loading data';
      notifyListeners();

      final restaurant = await apiService.getDetail(restaurantId);

      if (restaurant.id.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _restaurant = restaurant;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Something problem and Try again later\n\n$e';
    }
  }
}
