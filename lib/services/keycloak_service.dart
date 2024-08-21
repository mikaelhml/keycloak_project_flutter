// lib/services/keycloak_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constant.dart';

class KeycloakService {
  Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${Constants.keycloakUrl}/realms/${Constants.realm}/protocol/openid-connect/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'client_id': Constants.clientId,
        'username': username,
        'password': password,
        'grant_type': 'password',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Login sucesso: ' + data['access_token']);
      return data['access_token'];
    } else {
      print('Login falhou: ${response.statusCode} ${response.body}');
      return null;
    }
  }
}
