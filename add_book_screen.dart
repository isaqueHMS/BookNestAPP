import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addBook(BuildContext context) async {
    final String title = _titleController.text.trim();
    final String author = _authorController.text.trim();
    final String description = _descriptionController.text.trim();

    // Validação dos campos
    if (title.isEmpty || author.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos!')),
      );
      return;
    }

    // Armazena o livro no shared_preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? books = prefs.getStringList('books') ?? [];
    books.add('$title|$author|$description'); // Formato: título|autor|descrição
    await prefs.setStringList('books', books);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Livro adicionado com sucesso!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Livro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título do Livro'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(labelText: 'Autor do Livro'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição do Livro'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addBook(context),
              child: const Text('Adicionar Livro'),
            ),
          ],
        ),
      ),
    );
  }
}
