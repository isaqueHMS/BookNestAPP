import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = false;
  String? _verificationCode;
  bool _codeSent = false;
  final _formKey = GlobalKey<FormState>();

  // Simulação de uma função que verifica se o e-mail está cadastrado
  Future<bool> _checkIfEmailExists(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? registeredEmail = prefs.getString('email');
    return registeredEmail == email;
  }

  // Função que simula o envio do código de verificação
  void _sendVerificationCode() {
    setState(() {
      _verificationCode = "123456"; // Simulando código de verificação
      _codeSent = true;
    });

    // Aqui você poderia integrar um serviço real de envio de e-mails
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Código Enviado'),
          content: const Text(
              'Um código de verificação foi enviado para o seu e-mail. Por favor, insira o código para redefinir sua senha.'),
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

  // Função para redefinir a senha após verificação
  void _resetPassword(String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', newPassword);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Senha Redefinida'),
          content: const Text('Sua senha foi redefinida com sucesso.'),
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
      appBar: AppBar(
        title: const Text('Esqueceu a Senha?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Digite seu e-mail',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Por favor, insira um e-mail válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (!_codeSent)
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool emailExists = await _checkIfEmailExists(
                          _emailController.text.trim());
                      if (emailExists) {
                        _sendVerificationCode();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Erro'),
                              content: const Text(
                                  'E-mail não cadastrado. Verifique se o e-mail está correto.'),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text('Enviar Código de Verificação'),
                ),
              if (_codeSent)
                Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Insira o código de verificação',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value != _verificationCode) {
                          return 'Código inválido.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Digite a nova senha',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _resetPassword('novaSenha'); // Nova senha digitada
                        }
                      },
                      child: const Text('Redefinir Senha'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
