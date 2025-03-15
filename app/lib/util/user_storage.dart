import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorage {
  static const _userIdKey = 'userId';
  String _userId = '';
  final _secureStorage = const FlutterSecureStorage();

  Future<void> saveUserId(String userId) async {
    await _secureStorage.write(key: _userIdKey, value: userId);
    _userId = userId;
  }

  Future<String> getUserId() async {
    if (_userId.isNotEmpty) {
      return _userId;
    }

    final userId = await _secureStorage.read(key: _userIdKey);
    if (userId != null) {
      _userId = userId;
    }

    return userId ?? '';
  }

  Future<bool> hasUserId() async {
    return (await getUserId()).isNotEmpty;
  }

  Future<void> deleteUserId() async {
    await _secureStorage.delete(key: _userIdKey);
    _userId = '';
  }
}