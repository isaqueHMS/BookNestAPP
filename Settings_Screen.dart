import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function toggleTheme; // Adiciona o parâmetro toggleTheme

  const SettingsScreen({Key? key, required this.toggleTheme}) : super(key: key); // Adiciona o parâmetro no construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Tema
            ListTile(
              title: const Text('Tema'),
              subtitle: const Text('Alterar o tema do aplicativo'),
              trailing: Switch(
                value: Theme.of(context).brightness == Brightness.dark, // Use uma variável de estado para gerenciar o tema
                onChanged: (value) {
                  toggleTheme(); // Chame a função de alternância de tema
                },
              ),
            ),
            // Idioma
            ListTile(
              title: const Text('Idioma'),
              subtitle: const Text('Escolher o idioma do aplicativo'),
              onTap: () {
                // Adicione a lógica para escolher um idioma
              },
            ),
            // Notificações
            ListTile(
              title: const Text('Notificações'),
              subtitle: const Text('Ativar ou desativar notificações'),
              trailing: Switch(
                value: true, // Use uma variável de estado para gerenciar as notificações
                onChanged: (value) {
                  // Adicione a lógica para ativar/desativar notificações
                },
              ),
            ),
            // Gerenciar Conta
            ListTile(
              title: const Text('Gerenciar Conta'),
              subtitle: const Text('Alterar e-mail ou senha'),
              onTap: () {
                // Navegue para a tela de gerenciamento de conta
              },
            ),
            // Sobre
            ListTile(
              title: const Text('Sobre'),
              subtitle: const Text('Informações sobre o aplicativo'),
              onTap: () {
                // Adicione a lógica para mostrar informações sobre o aplicativo
              },
            ),
            // Mais opções
            ListTile(
              title: const Text('Mais Opções'),
              subtitle: const Text('Adicionar mais opções na tela de configurações'),
              onTap: () {
                // Adicione a lógica para mais opções
              },
            ),
          ],
        ),
      ),
    );
  }
}
