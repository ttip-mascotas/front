import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "History Pets",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const Home(),
    );
  }
}
