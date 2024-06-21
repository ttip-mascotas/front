import "package:flutter/material.dart";

class PetsScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;

  const PetsScaffold({
    required this.body,
    required this.title,
    this.floatingActionButton,
    this.drawer,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
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
      endDrawer: drawer,
    );
  }
}
