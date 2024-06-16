import "package:flutter/material.dart";

class InputTitle extends StatelessWidget {
  final String title;

  const InputTitle({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}
