import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewBooksScreen extends StatefulWidget {
  const ViewBooksScreen({super.key});

  @override
  _ViewBooksScreenState createState() => _ViewBooksScreenState();
}

class _ViewBooksScreenState extends State<ViewBooksScreen> {
  List<String> _books = []; // Lista de livros
  List<String> _filteredBooks = []; // Lista filtrada
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBooks(); // Carrega os livros quando a tela inicializa
  }

  // Carrega os livros do shared_preferences
  void _loadBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _books = prefs.getStringList('books') ?? [];
      _filteredBooks = _books; // Inicialmente, todos os livros são exibidos
    });
  }

  // Função para filtrar livros
  void _filterBooks(String query) {
    setState(() {
      _filteredBooks = _books.where((book) {
        final bookDetails = book.split('|'); // Divide os detalhes do livro
        final title = bookDetails[0].toLowerCase();
        return title.contains(query.toLowerCase()); // Verifica se o título contém a busca
      }).toList();
    });
  }

  void _showBookDetails(BuildContext context, String book) {
    final bookDetails = book.split('|');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(bookDetails[0]), // Título do livro
          content: Text('Autor: ${bookDetails[1]}\n\nDescrição: ${bookDetails[2]}'), // Descrição do livro
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
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
        title: const Text('Livros Cadastrados'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Pesquisar livros...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search), // Ícone de pesquisa
              ),
              onChanged: _filterBooks, // Atualiza a lista de livros à medida que o texto é digitado
            ),
          ),
        ),
      ),
      body: _filteredBooks.isNotEmpty
          ? ListView.builder(
              itemCount: _filteredBooks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredBooks[index].split('|')[0]), // Título
                  subtitle: Text(_filteredBooks[index].split('|')[1]), // Autor
                  onTap: () => _showBookDetails(context, _filteredBooks[index]), // Mostra os detalhes ao clicar
                );
              },
            )
          : const Center(child: Text('Nenhum livro cadastrado.')), // Mensagem quando não há livros
    );
  }
}
