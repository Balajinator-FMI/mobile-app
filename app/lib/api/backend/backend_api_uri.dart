import 'package:flutter_dotenv/flutter_dotenv.dart';

class BackendApiUri {
  final String _baseUrl = dotenv.env['BACKEND_API_BASE_URL']!;

  Uri registerUser() => Uri.parse('$_baseUrl/users');

  Uri fetchLocationData(String userId, double lat, double long) {
    return Uri.parse('$_baseUrl/users/$userId').replace(
      queryParameters: {
        'lat': lat.toString(),
        'lon': long.toString(),
      },
    );
  }

  Uri diagnoseUser() => Uri.parse('$_baseUrl/ml/diagnosis');
}
