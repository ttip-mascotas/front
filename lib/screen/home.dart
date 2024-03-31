import 'package:flutter/material.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/widget/pet_detail.dart';

import '../widget/medical_visit_registration_form.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final petDatasource = PetsDatasource(api: Api());

  @override
  Widget build(BuildContext context) {
    final purple = Colors.purple.shade200;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Historial Médico",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: purple,
      ),
      body: makePetDetails(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        onPressed: () => openMedicalVisitRegistrationModal(context),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  FutureBuilder<Pet> makePetDetails() {
    return FutureBuilder<Pet>(
      future: petDatasource.getPet(2),
      builder: (BuildContext context, AsyncSnapshot<Pet> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Flexible(child: Text("${snapshot.error}")),
              ],
            ),
          );
        } else {
          return PetDetail(pet: snapshot.data!);
        }
      },
    );
  }

  void openMedicalVisitRegistrationModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        builder: (BuildContext context) =>
            const MedicalVisitRegistrationForm());
  }
}
