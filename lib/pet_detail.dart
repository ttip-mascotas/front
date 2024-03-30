import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mascotas/model/pet.dart';

class PetDetail extends StatelessWidget {
  const PetDetail({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    var image = MemoryImage(base64Decode(pet.photo));

    final avatar = CircleAvatar(
      backgroundImage: image,
      radius: 60,
    );

    final attributes = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pet.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        buildPetAttributeRow("Edad", pet.ageToString()),
        buildPetAttributeRow("Nacimiento", pet.birthdateToString()),
        buildPetAttributeRow("Peso", pet.weightToString()),
        buildPetAttributeRow("Sexo", pet.sex),
        buildPetAttributeRow("Raza", pet.breed),
        buildPetAttributeRow("Pelaje", pet.fur),
      ],
    );

    final details = Container(
      padding: const EdgeInsets.all(20),
      color: Colors.purple.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          avatar,
          attributes,
        ],
      ),
    );

    final visitations = Container(
      padding: const EdgeInsets.all(20),
      child: const Row(
        children: [
          Text("No hay visitas médicas registradas."),
        ],
      ),
    );

    return Column(
      children: [
        details,
        visitations,
      ],
    );
  }

  Row buildPetAttributeRow(String attributeName, String attributeValue) {
    return Row(
      children: [
        Text(
          "$attributeName: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(attributeValue.isEmpty ? "-" : attributeValue)
      ],
    );
  }
}
