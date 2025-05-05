import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final secureStorage = const FlutterSecureStorage();

  Future<void> storeToken(String accessToken) async {
    return await secureStorage.write(key: 'access_token', value: accessToken);
  }

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<void> removeToken() async {
    return await secureStorage.delete(key: 'access_token');
  }
}
