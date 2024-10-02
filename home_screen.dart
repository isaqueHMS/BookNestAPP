import 'package:flutter/material.dart';
import 'add_book_screen.dart'; // Importa a tela para adicionar livros
import 'view_books_screen.dart'; // Importa a tela para visualizar livros
import 'settings_screen.dart'; // Importa a tela de configurações

class HomeScreen extends StatelessWidget {
  final Function toggleTheme;

  const HomeScreen({Key? key, required this.toggleTheme}) : super(key: key); // Recebe a função para alternar o tema

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookNest'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade800
                  : Colors.green.shade100,
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade600
                  : Colors.green.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center( // Envolve todo o conteúdo em Center
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // O conteúdo ocupará o mínimo de espaço vertical necessário
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
              crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
              children: <Widget>[
                const Text(
                  'Escolha uma opção abaixo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center, // Centraliza o texto
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewBooksScreen()), // Navega para a tela de visualização de livros
                    );
                  },
                  icon: const Icon(Icons.book, color: Colors.white),
                  label: const Text('Ver Livros Cadastrados'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddBookScreen()), // Navega para a tela de adicionar livros
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Adicionar Livro'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.blue.shade600,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(toggleTheme: toggleTheme), // Passa a função para as configurações
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings, color: Colors.white),
                  label: const Text('Configurações'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.orange.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
