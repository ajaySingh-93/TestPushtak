import 'package:flutter/material.dart';

class BatchesScreen extends StatelessWidget {
  const BatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Batches"),
      ),
      body: const Center(
        child: Text("Batches Screen"),
      ),
    );
  }
}
