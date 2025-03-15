import 'package:app/api/backend/dto/fetch_location_data_res.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../api/backend/dto/curr_uv_data.dart';
import '../../api/backend/dto/forecast_item.dart';
import '../../api/google-maps/google_maps_api_service.dart';
import '../../api/google-maps/model/city_model.dart';

class SearchViewModel extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  final GoogleMapsApiService _googleMapsApiService = GoogleMapsApiService();
  final Location _location = Location();
  CityModel? selectedCity;
  FetchLocationDataRes? locationData;
  bool isLoading = false;

  void changeLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }

  Future<List<CityModel>> getCitySuggestions(String query) async {
    if (query.isEmpty) return [];

    try {
      LocationData currentLocation = await _location.getLocation();
      return await _googleMapsApiService.autocomplete(query, currentLocation);
    } catch (error) {
      return [];
    }
  }

  void selectCity(CityModel city) {
    changeLoadingState(true);
    controller.text = city.name;
    selectedCity = city;
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
      locationData = FetchLocationDataRes(
        _mockForecastItems(),
        _mockForecastItems(),
        _mockCurrUvData(),
        45, // Mock recommended outdoor time in minutes
        "It's safe to go outside, but wear sunscreen!",
        30, // Mock UV protection factor
      );
      changeLoadingState(false);
    } catch (e) {
      print(e);
    }
  }

  // Mock ForecastItem list
  List<ForecastItem> _mockForecastItems() {
    return [
      ForecastItem(5, DateTime.now().subtract(const Duration(days: 1)).toIso8601String()),
      ForecastItem(6, DateTime.now().subtract(const Duration(days: 5)).toIso8601String()),
      ForecastItem(6, DateTime.now().subtract(const Duration(days: 4)).toIso8601String()),
      ForecastItem(6, DateTime.now().subtract(const Duration(days: 3)).toIso8601String()),
    ];
  }

  CurrUvData _mockCurrUvData() {
    return CurrUvData(
      4, // Mock UV Index
      25.5, // Mock Temperature (°C)
      DateTime.now().add(const Duration(hours: -2)), // Mock Sunrise (2 hours ago)
      DateTime.now().add(const Duration(hours: 5)), // Mock Sunset (5 hours from now)
    );
  }
}