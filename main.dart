import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importa a tela de login
import 'home_screen.dart'; // Certifique-se de importar a HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false; // Variável para controlar o tema

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme; // Alterna entre os temas
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookNest',
      theme: _isDarkTheme
          ? ThemeData.dark() // Tema escuro
          : ThemeData.light(), // Tema claro
      home: LoginScreen(
        toggleTheme: _toggleTheme, // Passa a função para LoginScreen
      ),
    );
  }
}
