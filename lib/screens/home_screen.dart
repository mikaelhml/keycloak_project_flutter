// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  final AuthService _authService = AuthService();

  HomeScreen({required this.user});

  void _logout(BuildContext context) async {
    await _authService.logout(); // Chama a função de logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem-vindo, ${user.username}!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context), // Chama a função de logout ao pressionar
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
