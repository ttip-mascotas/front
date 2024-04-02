import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mascotas/model/medicalVisit.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/utils/format.dart';

class PetDetail extends StatelessWidget {
  const PetDetail({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          color: Colors.purple.shade50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Avatar(photo: pet.photo),
              PetAttributes(pet: pet),
            ],
          ),
        ),
        MedicalVisits(medicalVisits: pet.medicalVisits),
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.photo,
  });

  final String photo;

  @override
  Widget build(BuildContext context) {
    var image = MemoryImage(base64Decode(photo));

    return CircleAvatar(
      backgroundImage: image,
      radius: 60,
    );
  }
}

class PetAttributes extends StatelessWidget {
  final Pet pet;

  const PetAttributes({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pet.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        PetAttribute(
          attributeValue: pet.ageToString(),
          attributeName: 'Edad',
        ),
        PetAttribute(
          attributeValue: pet.birthdateToString(),
          attributeName: 'Nacimiento',
        ),
        PetAttribute(
          attributeValue: pet.weightToString(),
          attributeName: 'Peso',
        ),
        PetAttribute(
          attributeValue: pet.sex,
          attributeName: 'Sexo',
        ),
        PetAttribute(
          attributeValue: pet.breed,
          attributeName: 'Raza',
        ),
        PetAttribute(
          attributeValue: pet.fur,
          attributeName: 'Pelaje',
        ),
      ],
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

class MedicalVisits extends StatelessWidget {
  final List<MedicalVisit> medicalVisits;

  const MedicalVisits({
    super.key,
    required this.medicalVisits,
  });

  @override
  Widget build(BuildContext context) {
    return medicalVisits.isNotEmpty
        ? Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final medicalVisit = medicalVisits[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MedicalVisitDetail(
                          text: medicalVisit.specialist,
                          icon: Icons.medical_services_rounded,
                        ),
                        MedicalVisitDetail(
                          text: medicalVisit.address,
                          icon: Icons.location_on,
                        ),
                        MedicalVisitDetail(
                          text: formatDateToString(medicalVisit.date),
                          icon: Icons.calendar_month_rounded,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            medicalVisit.observations,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(color: Colors.purple.shade200,),
                itemCount: medicalVisits.length),
          )
        : Container(
            padding: const EdgeInsets.all(20),
            child: const Row(
              children: [
                Text("No hay visitas médicas registradas."),
              ],
            ),
          );
  }
}

class MedicalVisitDetail extends StatelessWidget {
  final IconData icon;
  final String text;

  const MedicalVisitDetail({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon, color: Colors.purple.shade200),
          ),
          Text(text),
        ],
      ),
    );
  }
}
