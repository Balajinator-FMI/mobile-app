import 'package:app/api/backend/dto/register_user_req.dart';
import 'package:app/api/backend/user_service.dart';
import 'package:app/static/dependency_injection.dart';
import 'package:app/util/user_storage.dart';

class UserRepository {
  final _userService = DependencyInjection.getIt<UserService>();
  final _userStorage = DependencyInjection.getIt<UserStorage>();

  Future<void> registerUser(RegisterUserReq userData) async {
    final result = await _userService.registerUser(userData);
    await _userStorage.saveUserId(result.userId);
  }
}