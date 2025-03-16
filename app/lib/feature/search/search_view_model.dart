import 'package:app/api/backend/dto/fetch_location_data_res.dart';
import 'package:app/api/backend/user_repository.dart';
import 'package:app/static/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../../api/google-maps/google_maps_api_service.dart';
import '../../api/google-maps/model/city_model.dart';

class SearchViewModel extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  final GoogleMapsApiService _googleMapsApiService = GoogleMapsApiService();
  final _userRepository = DependencyInjection.getIt<UserRepository>();
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
      final coord = await _googleMapsApiService.getCoordinatesFromPlaceId(selectedCity!.id);
      locationData = await _userRepository.fetchLocationData(coord['lat']!, coord['lon']!);
      print(locationData);
      changeLoadingState(false);
    } catch (e) {
      print(e);
    }
  }
}
