// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    try {
      // Tenta fazer login online
      final user = await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
        );
      } else {
        // Se o login online falhar, tenta login offline
        _tryOfflineLogin();
      }
    } catch (e) {
      // Se ocorrer um erro, como um timeout, tenta login offline
      print("Erro ao tentar fazer login: $e");
      _tryOfflineLogin();
    }
  }

  void _tryOfflineLogin() async {
    final offlineUser = await _authService.loginOffline(
      _usernameController.text,
      _passwordController.text,
    );

    if (offlineUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(user: offlineUser)),
      );
    } else {
      // Exibir mensagem de erro se o login offline também falhar
      _showErrorSnackBar("Login falhou. Verifique suas credenciais.");
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(onPressed: _login, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}
