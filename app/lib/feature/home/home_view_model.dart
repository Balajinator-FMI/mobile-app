import 'package:app/api/backend/dto/curr_uv_data.dart';
import 'package:app/api/backend/dto/fetch_location_data_res.dart';
import 'package:app/api/backend/dto/forecast_item.dart';
import 'package:app/api/backend/user_repository.dart';
import 'package:app/static/dependency_injection.dart';
import 'package:app/storage/user_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = true;
  LocationData? _currLocation;
  FetchLocationDataRes? _locationData;
  final _userRepository = DependencyInjection.getIt<UserRepository>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _userLocalStorage = DependencyInjection.getIt<UserLocalStorage>();

  HomeViewModel() {
    fetchUserData().then((_) {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> fetchUserData() async {
    final location = Location();
    _currLocation = await location.getLocation();

    try {
      // await Future.delayed(Duration(seconds: 1)); // Simulate API delay
      // _locationData = FetchLocationDataRes(
      //   _mockForecastItems(),
      //   _mockForecastItems(),
      //   _mockCurrUvData(),
      //   45, // Mock recommended outdoor time in minutes
      //   "It's safe to go outside, but wear sunscreen!",
      //   30, // Mock UV protection factor
      // );
      _locationData = await _userRepository.fetchLocationData(_currLocation!.latitude!, _currLocation!.longitude!);
    } catch (e) {
      print(e);
    }
  }

  List<Map<String, dynamic>> getOutdoorTimes() {
    final List<Map<String, dynamic>> outdoorTimes = [];

    for (final el in _userLocalStorage.outdoorTimes) {
      final matchedForecast = _locationData!.pastWeek!.firstWhere(
        (element) => _isSameDate(el.date, DateTime.parse(element.date)), // Compare dates
        orElse: () => ForecastItem.empty(),
      );

      if (matchedForecast != ForecastItem.empty()) {
        outdoorTimes.add({
          'totalHours': el.totalHours,
          'date': el.date,
          'uvIndex': matchedForecast.uvIndex,
        });
      }
    }

    return outdoorTimes;
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  void navigateToChat() {
    _navigationService.navigateTo('chat');
  }

  void navigateToSearch() {
    _navigationService.navigateTo('search');
  }

  bool get isLoading => _isLoading;
  FetchLocationDataRes get locationData => _locationData!;
}

// // Mock ForecastItem list
// List<ForecastItem> _mockForecastItems() {
//   return [
//     ForecastItem(5, DateTime.now().subtract(Duration(days: 1)).toIso8601String()),
//     ForecastItem(6, DateTime.now().subtract(Duration(days: 5)).toIso8601String()),
//     ForecastItem(6, DateTime.now().subtract(Duration(days: 4)).toIso8601String()),
//     ForecastItem(6, DateTime.now().subtract(Duration(days: 3)).toIso8601String()),
//   ];
// }

// CurrUvData _mockCurrUvData() {
//   return CurrUvData(
//     4, // Mock UV Index
//     25.5, // Mock Temperature (°C)
//     DateTime.now().add(Duration(hours: -2)), // Mock Sunrise (2 hours ago)
//     DateTime.now().add(Duration(hours: 5)), // Mock Sunset (5 hours from now)
//   );
// }
