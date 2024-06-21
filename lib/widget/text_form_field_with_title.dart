import "package:flutter/material.dart";
import "input_title.dart";

class TextFormFieldWithTitle extends StatelessWidget {
  const TextFormFieldWithTitle({
    super.key,
    required this.controller,
    required this.title,
    this.validator,
    required,
    this.onTap,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String title;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onTapSuffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(
          title: title,
        ),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          readOnly: readOnly,
          onTap: onTap,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
                onTap: onTapSuffixIcon, child: Icon(suffixIcon)),
          ),
        ),
      ],
    );
  }
}
