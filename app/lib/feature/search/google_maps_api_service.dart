import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../../static/dependency_injection.dart';
import 'city_model.dart';
import 'google_maps_api_uri.dart';

class GoogleMapsApiService {
  final GoogleMapsApiUri _apiUri = DependencyInjection.getIt<GoogleMapsApiUri>();

  Future<List<CityModel>> autocomplete(String input, LocationData origin) async {
    final response = await http.get(_apiUri.autocomplete({
      'input': input,
      'origin': '${origin.latitude},${origin.longitude}',
      'locationbias': 'ipbias',
      'types': '(cities)',
    })).onError((error, stackTrace) {
      throw Exception('Failed to load cities');
    });

    if (response.statusCode == HttpStatus.ok) {
      final responseBody = json.decode(response.body);
      return responseBody['predictions']
          .map<CityModel>((city) => CityModel.fromJson(city)).
          toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }
}