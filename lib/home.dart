import 'package:flutter/material.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/pet_detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final petDatasource = PetsDatasource(api: Api());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Historial Médico",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,
      ),
      body: makePetDetails(),
    );
  }

  FutureBuilder<Pet> makePetDetails() {
    return FutureBuilder<Pet>(
      future: petDatasource.getPet(1),
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
}
