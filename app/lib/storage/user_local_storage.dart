import 'package:app/storage/model/outdoor_time.dart';

class UserLocalStorage {
  final List<OutdoorTime> outdoorTimes = [
    OutdoorTime(DateTime.now(), 2),
    OutdoorTime(DateTime.now().subtract(Duration(days: 1)), 3),
    OutdoorTime(DateTime.now().subtract(Duration(days: 2)), 4),
    OutdoorTime(DateTime.now().subtract(Duration(days: 3)), 5),
    OutdoorTime(DateTime.now().subtract(Duration(days: 4)), 2),
  ];
}