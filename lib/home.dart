import 'package:flutter/material.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/pet_detail.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
      body: PetDetail(pet: getPet()),
    );
  }
}

Pet getPet() {
  return Pet(
    id: 1,
    name: "Pippin",
    age: 6,
    weight: 8.2,
    photo: "",
    birthdate: DateTime.utc(2004, 11, 20),
    breed: "Callejero",
    fur: "Largo",
    sex: "MALE",
  );
}
