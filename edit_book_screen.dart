import 'package:flutter/material.dart';

class EditBookScreen extends StatefulWidget {
  final String currentTitle;
  final Function(String) onEditBook;

  const EditBookScreen({super.key, required this.currentTitle, required this.onEditBook});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  late TextEditingController _bookController;

  @override
  void initState() {
    super.initState();
    _bookController = TextEditingController(text: widget.currentTitle);
  }

  void _submit() {
    final newTitle = _bookController.text;
    if (newTitle.isNotEmpty) {
      widget.onEditBook(newTitle); // Edita o livro na lista
      Navigator.pop(context); // Volta para a tela anterior
    } else {
      // Exibe um erro se o título estiver vazio
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: const Text('O título do livro não pode estar vazio.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Livro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _bookController,
              decoration: const InputDecoration(labelText: 'Título do Livro'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
