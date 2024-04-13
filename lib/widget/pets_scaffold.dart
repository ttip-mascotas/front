import 'package:flutter/material.dart';

class PetsScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? floatingActionButton;

  const PetsScaffold({
    required this.body,
    required this.title,
    this.floatingActionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}