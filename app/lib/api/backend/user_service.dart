import 'dart:convert';
import 'dart:io';

import 'package:app/api/backend/backend_api_uri.dart';
import 'package:app/api/backend/dto/diagnose_user_res.dart';
import 'package:app/api/backend/dto/fetch_location_data_res.dart';
import 'package:app/api/backend/dto/register_user_req.dart';
import 'package:app/api/backend/dto/register_user_res.dart';
import 'package:app/static/app_strings.dart';
import 'package:app/static/dependency_injection.dart';
import 'package:http/http.dart' as http;

class UserService {
  final BackendApiUri _backendApiUri = DependencyInjection.getIt<BackendApiUri>();

  Future<RegisterUserRes> registerUser(RegisterUserReq userData) async {
    final requestData = {
      'biologicalSex': userData.gender.name.toUpperCase(),
      'years': userData.years,
      'skinType': userData.skinType.name.toUpperCase(),
      'skinDiseases': userData.diseases.map((disease) => disease.name.toUpperCase().replaceAll(' ', '_')).toList(),
    };

    print(requestData);

    final response = await http
        .post(
      _backendApiUri.registerUser(),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestData),
    )
        .onError((error, stackTrace) {
      throw Exception(AppStrings.failedToEstablishConnectionWithServer);
    });

    if (response.statusCode == HttpStatus.ok) {
      final responseBody = json.decode(response.body);
      return RegisterUserRes.fromJson(responseBody);
    } else {
      throw Exception(AppStrings.failedToRegisterUser);
    }
  }

  Future<FetchLocationDataRes> fetchLocationData(String userId, double lat, double lng) async {
    print(_backendApiUri.fetchLocationData(userId, lat, lng));

    final response = await http.get(_backendApiUri.fetchLocationData(userId, lat, lng)).onError((error, stackTrace) {
      throw Exception(AppStrings.failedToEstablishConnectionWithServer);
    });

    if (response.statusCode == HttpStatus.ok) {
      final responseBody = json.decode(response.body);
      print(responseBody);
      return FetchLocationDataRes.fromJson(responseBody);
    } else {
      throw Exception(AppStrings.failedToLoadLocationData);
    }
  }

  Future<Map<String, Object>> diagnoseUser(String base64Image) async {
    final response = await http
        .post(
      _backendApiUri.diagnoseUser(),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'image': base64Image}),
    )
        .onError((error, stackTrace) {
      throw Exception(AppStrings.failedToEstablishConnectionWithServer);
    });

    print(json.decode(response.body));

    if (response.statusCode == HttpStatus.ok) {
      final responseBody = DiagnoseUserRes.fromJson(json.decode(response.body));
      final diagnosis = {
        'disease': responseBody.predictedClass,
        'probability': DiagnoseUserRes.parsePercentage(responseBody.getProbability(responseBody.predictedClass)),
      };
      return diagnosis;
    } else {
      throw Exception(AppStrings.failedToDiagnoseUser);
    }
  }
}
