import 'package:flutter/material.dart';
import 'input_title.dart';

class TextFormFieldWithTitle extends StatelessWidget {
  const TextFormFieldWithTitle(
  {super.key,
  required this.nameController,
  required this.title,
  this.validator,
  required});

final TextEditingController nameController;
final String title;
final String? Function(String?)? validator;

@override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InputTitle(
        title: title,
      ),
      TextFormField(
        controller: nameController,
        validator: validator,
      ),
    ],
  );
}
}