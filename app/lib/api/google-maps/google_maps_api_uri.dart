import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleMapsApiUri {
  final String _apiKey = dotenv.env['GOOGLE_MAPS_API_KEY']!;
  final String _baseUrl = 'maps.googleapis.com';
  final String _path = '/maps/api/place/autocomplete/json';

  Uri autocomplete(Map<String, String> queryParameters) {
    return Uri.https(
      _baseUrl,
      _path,
      queryParameters..addAll({
        'key': _apiKey
      }),
    );
  }

  Uri getCoordinatesFromPlaceId(String placeId) {
    return Uri.https(
      _baseUrl,
      '/maps/api/place/details/json',
      {
        'place_id': placeId,
        'key': _apiKey,
      },
    );
  }
}