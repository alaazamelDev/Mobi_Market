import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:products_management/data/content_providers/auth_service_provider.dart';
import 'package:products_management/data/repositories/shared_prefs_repository.dart';

class AuthRepository {
  final SharedPrefsRepository _prefsRepository;
  final AuthServiceProvider _authProvider = AuthServiceProvider();

  AuthRepository(FlutterSecureStorage storage)
      : _prefsRepository = SharedPrefsRepository(storage);

  // check if user already signed in or not
  Future<bool> hasToken() async {
    var value = await _prefsRepository.getAccessToken();
    return value != null;
  }

  // store user token in internal storage for later check
  Future<void> presistToken(String token) async {
    await _prefsRepository.saveAccessToken(token);
  }

  // delete user token
  Future<void> deleteToken() async {
    await _prefsRepository.deleteAccessToken();
  }

  // send login request
  Future login(String email, String password) async {
    var response = await _authProvider.loginUser(email, password);
    return response;
  }

  // send logout request
  Future logout(String token) async {
    var response = await _authProvider.logoutUser(token);
    return response;
  }
}
