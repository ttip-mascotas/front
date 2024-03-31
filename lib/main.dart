import 'package:flutter/material.dart';
import 'package:mascotas/style/theme.dart';

import 'screen/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "History Pets",
      theme: theme,
      home: const Home(),
    );
  }
}
