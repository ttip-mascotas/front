import "package:flutter/material.dart";
import "package:mascotas/model/pet.dart";
import "package:mascotas/utils/format.dart";
import "package:mascotas/widget/pet_tab_controller.dart";

import "avatar.dart";

class PetDetail extends StatelessWidget {
  const PetDetail({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.purple.shade50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Avatar.avatarLargeURL(
                url: pet.photo,
              ),
              PetAttributes(pet: pet),
            ],
          ),
        ),
        PetTabController(pet: pet),
      ],
    );
  }
}

class PetAttributes extends StatelessWidget {
  final Pet pet;

  const PetAttributes({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                pet.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            PetAttribute(
              attributeValue: convertAgeToString(pet.age),
              attributeName: "Edad",
            ),
            PetAttribute(
              attributeValue: formatDateToString(pet.birthdate),
              attributeName: "Nacimiento",
            ),
            PetAttribute(
              attributeValue: convertWeightToString(pet.weight),
              attributeName: "Peso",
            ),
            PetAttribute(
              attributeValue: pet.sex,
              attributeName: "Sexo",
            ),
            PetAttribute(
              attributeValue: pet.breed,
              attributeName: "Raza",
            ),
            PetAttribute(
              attributeValue: pet.fur,
              attributeName: "Pelaje",
            ),
          ],
        ),
      ),
    );
  }
}

class PetAttribute extends StatelessWidget {
  final String attributeValue;
  final String attributeName;

  const PetAttribute(
      {super.key, required this.attributeValue, required this.attributeName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: "$attributeName: ",
          children: [
            TextSpan(
                text: attributeValue.isEmpty ? "-" : attributeValue,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400))
          ],
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
