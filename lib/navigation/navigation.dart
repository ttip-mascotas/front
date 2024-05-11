import 'package:flutter/material.dart';
import 'package:mascotas/screen/pet_screen.dart';
import 'package:mascotas/screen/search_screen.dart';

class Navigation {

  static void goToPetScreen({required BuildContext context, required int id}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PetScreen(id: id),
      ),
    );
  }

  static void goToSearchScreen({required BuildContext context}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      ),
    );
  }
}