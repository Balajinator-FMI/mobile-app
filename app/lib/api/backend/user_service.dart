import 'dart:convert';
import 'dart:io';

import 'package:app/api/backend/backend_api_uri.dart';
import 'package:app/api/backend/dto/register_user_req.dart';
import 'package:app/api/backend/dto/register_user_res.dart';
import 'package:app/static/app_strings.dart';
import 'package:app/static/dependency_injection.dart';
import 'package:http/http.dart' as http;

class UserService {
  final BackendApiUri _backendApiUri = DependencyInjection.getIt<BackendApiUri>();

  Future<RegisterUserRes> registerUser(RegisterUserReq userData) async {
    final response = await http.post(
      _backendApiUri.registerUser(),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userData.toJson()),
    ).onError((error, stackTrace) {
      throw Exception(AppStrings.failedToEstablishConnectionWithServer);
    });

    if (response.statusCode == HttpStatus.ok) {
      final responseBody = json.decode(response.body);
      return RegisterUserRes.fromJson(responseBody);
    } else {
      throw Exception(AppStrings.failedToRegisterUser);
    }
  }
}
