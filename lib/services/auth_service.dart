// lib/services/auth_service.dart
import 'keycloak_service.dart';
import 'token_service.dart';
import '../models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final KeycloakService _keycloakService = KeycloakService();
  final TokenService _tokenService = TokenService();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<User?> login(String username, String password) async {
    final token = await _keycloakService.login(username, password);
    if (token != null) {
      await _storage.write(key: 'accessToken', value: token);
      await _storage.write(key: 'username', value: username);
      await _storage.write(key: 'password', value: password);
      return User(username: username, accessToken: token);
    }
    return null;
  }

  Future<User?> loginOffline(String username, String password) async {
    final storedUsername = await _storage.read(key: 'username');
    final storedPassword = await _storage.read(key: 'password');

    if (storedUsername == username && storedPassword == password) {
      return User(username: username, accessToken: 'offline-token');
    }
    return null;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'accessToken');
    // await _storage.delete(key: 'username'); // Remove o nome de usuário
    // await _storage.delete(key: 'password'); // Remove a senha
  }

  Future<String?> getStoredToken() async {
    return await _storage.read(key: 'accessToken');
  }
}
