import 'package:flutter/material.dart';
import '../../model/book_model.dart';
import '../../widgets/book_card.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: sampleBooks.length,
        itemBuilder: (context, index) {
          return BookCard(book: sampleBooks[index]);
        },
      ),
    );
  }
}
