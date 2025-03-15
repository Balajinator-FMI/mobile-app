import 'package:flutter_dotenv/flutter_dotenv.dart';

class BackendApiUri {
  final String _baseUrl = dotenv.env['BACKEND_API_BASE_URL']!;

  Uri registerUser() => Uri.parse('$_baseUrl/user/register');

  Uri fetchLocationData(String userId, double lat, double long, bool forecastHistory) {
    return Uri.parse('$_baseUrl/users/$userId/location').replace(
      queryParameters: {
        'lat': lat.toString(),
        'long': long.toString(),
        'forecastHistory': forecastHistory.toString(),
      },
    );
  }
}
