// ignore: prefer_double_quotes
import 'package:flutter/material.dart';

class PetFloatingActionButton extends StatelessWidget {
  const PetFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final void Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.purple.shade200,
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
