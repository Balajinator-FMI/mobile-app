import 'dart:convert';
import 'package:app/api/backend/user_repository.dart';
import 'package:app/static/dependency_injection.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

final Location location = Location();

Future<void> initLocationService() async {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) return;
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) return;
  }

  location.changeSettings(
    accuracy: LocationAccuracy.low,
    interval: 600000, // 10min
  );
}

void startLocationTracking() {
  location.onLocationChanged.listen((LocationData currentLocation) async {
    double latitude = currentLocation.latitude!;
    double longitude = currentLocation.longitude!;

    int uvIndex = await fetchUVIndex(latitude, longitude);

    if (uvIndex > 2 && isActive) {
      startTimerIfNotRunning();
    } else {
      stopTimerIfRunning();
    }
  });
}

Future<int> fetchUVIndex(double lat, double lon) async {
  final _userRepository = DependencyInjection.getIt<UserRepository>();
  final result = await _userRepository.fetchLocationData(lat, lon);

  return result.currentUvData.uvIndex;
}

// final ActivityRecognition _activityRecognition = ActivityRecognition();
bool isActive = false;

// void startActivityTracking() {
//   _activityRecognition.activityStream().listen((ActivityEvent activity) {
//     if (activity.type == ActivityType.WALKING ||
//         activity.type == ActivityType.RUNNING ||
//         activity.type == ActivityType.ON_BICYCLE) {
//       isActive = true;
//     } else {
//       isActive = false;
//     }
//   });
// }

Stopwatch stopwatch = Stopwatch();
Duration totalOutdoorTime = Duration.zero;

void startTimerIfNotRunning() {
  if (!stopwatch.isRunning) {
    stopwatch.start();
  }
}

void stopTimerIfRunning() {
  if (stopwatch.isRunning) {
    stopwatch.stop();
    totalOutdoorTime += stopwatch.elapsed;
    stopwatch.reset();
  }
}
