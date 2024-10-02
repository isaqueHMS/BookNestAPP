import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart'; // Importe sua tela home

class RegisterScreen extends StatefulWidget {
  final Function toggleTheme; // Função para alternar o tema

  const RegisterScreen({super.key, required this.toggleTheme}); // Recebe a função no construtor

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Função para salvar o cadastro
  void _register() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Verifica se o e-mail contém o formato correto
    if (!email.contains('@')) {
      _showErrorDialog('Por favor, insira um e-mail válido.');
      return;
    }

    // Verifica se a senha tem o comprimento mínimo
    if (password.length < 6) {
      _showErrorDialog('A senha deve ter pelo menos 6 caracteres.');
      return;
    }

    // Verifica se as senhas coincidem
    if (password != confirmPassword) {
      _showErrorDialog('As senhas não coincidem.');
      return;
    }

    // Salva o e-mail e senha
    await prefs.setString('email', email);
    await prefs.setString('password', password);

    // Mostra uma mensagem de sucesso
    _showSuccessDialog();
  }

  // Mostra o diálogo de sucesso e navega para a tela principal
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Cadastro realizado com sucesso!'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(toggleTheme: widget.toggleTheme)), // Passa a função para HomeScreen
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Mostra caixa de diálogo de erro
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white, // Altera a cor do fundo baseado no tema
          image: Theme.of(context).brightness == Brightness.dark
              ? null
              : const DecorationImage(
                  image: AssetImage('assets/background_books.png'), // Substitua pela sua imagem de fundo
                  fit: BoxFit.cover,
                ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cadastre-se no BookNest',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,  // Mudança para a cor preta
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('CADASTRAR'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Volta para a tela de login
                  },
                  child: const Text('Já tem uma conta? Faça login!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
