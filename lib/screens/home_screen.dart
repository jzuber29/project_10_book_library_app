import 'package:flutter/material.dart';
import '../models/book.dart';
import 'add_book_screen.dart';
import 'book_detail_screen.dart';
import '../widgets/book_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Book> _books = [];

  void _addBook(Book book) {
    setState(() {
      _books.add(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Library')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Categories', style: TextStyle(color: Colors.white)),
            ),
            ListTile(title: Text('All')),
            ListTile(title: Text('Fiction')),
            ListTile(title: Text('Non-Fiction')),
          ],
        ),
      ),
      body: _books.isEmpty
          ? const Center(child: Text('No books added yet!'))
          : ListView.builder(
              itemCount: _books.length,
              itemBuilder: (ctx, index) {
                final book = _books[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                  child: BookCard(book: book),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newBook = await Navigator.push<Book>(
            context,
            MaterialPageRoute(builder: (ctx) => AddBookScreen()),
          );
          if (newBook != null) {
            _addBook(newBook);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
