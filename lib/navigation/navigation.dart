import 'package:flutter/material.dart';
import 'package:mascotas/screen/pet_screen.dart';

class Navigation {

  static void goToPetScreen({required BuildContext context, required int id}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PetScreen(id: id),
      ),
    );
  }
}