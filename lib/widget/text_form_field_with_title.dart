import "package:flutter/material.dart";
import "input_title.dart";

class TextFormFieldWithTitle extends StatelessWidget {
  const TextFormFieldWithTitle({
    super.key,
    required this.nameController,
    required this.title,
    this.validator,
    required,
    this.onTap,
    this.readOnly = false,
  });

  final TextEditingController nameController;
  final String title;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;

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
          readOnly: readOnly,
          onTap: onTap,
        ),
      ],
    );
  }
}
