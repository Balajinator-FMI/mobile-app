import 'package:app/api/backend/dto/fetch_location_data_res.dart';
import 'package:app/api/backend/dto/register_user_req.dart';
import 'package:app/api/backend/user_service.dart';
import 'package:app/static/dependency_injection.dart';
import 'package:app/storage/user_secure_storage.dart';

class UserRepository {
  final _userService = DependencyInjection.getIt<UserService>();
  final _userSecureStorage = DependencyInjection.getIt<UserSecureStorage>();

  Future<void> registerUser(RegisterUserReq userData) async {
    final result = await _userService.registerUser(userData);
    print(result);
    await _userSecureStorage.saveUserId(result.id);
  }

  Future<FetchLocationDataRes> fetchLocationData(double lat, double lng) async {
    final userId = await _userSecureStorage.getUserId();
    return await _userService.fetchLocationData(userId, lat, lng);
  }

  Future<Map<String, Object>> diagnoseUser(String base64Image) async {
    return await _userService.diagnoseUser(base64Image);
  }
}
