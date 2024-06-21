import "package:flutter/material.dart";
import "package:mascotas/screen/analysis_screen.dart";
import "package:mascotas/screen/groups_screen.dart";
import "package:mascotas/screen/pet_screen.dart";
import "package:mascotas/screen/pets_screen.dart";
import "package:mascotas/screen/search_screen.dart";
import "package:mascotas/screen/treatment_schedule_screen.dart";

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

  static void goToTreatmentScheduleScreen(
      {required BuildContext context, required int id}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TreatmentScheduleScreen(id: id),
      ),
    );
  }

  static void goToGroupScreen({required BuildContext context}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const GroupsScreen(),
      ),
    );
  }

  static goToPetsScreen({required BuildContext context, required int id}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PetsScreen(id: id,),
      ),
    );
  }

  static goToAnalysisScreen({required BuildContext context, required int id}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AnalysisScreen(id: id,),
      ),
    );
  }
}
