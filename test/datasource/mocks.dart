import 'dart:convert';

import 'package:mascotas/model/medicalVisit.dart';
import 'package:mascotas/model/pet.dart';

final Map<String, dynamic> petMap = {
  "id": 1,
  "name": "Lola",
  "photo": "",
  "age": 2,
  "weight": 35.0,
  "birthdate": "2023-03-30",
  "breed": "San Bernardo",
  "fur": "Largo",
  "sex": "FEMALE"
};

final String petJson = jsonEncode(
  petMap
);

final Map<String, dynamic > medicalVisitMap = {
  "id": 1,
  "address": "Alsina 1309, Quilmes",
  "datetime": "2023-03-30",
  "specialist": "Mariana",
  "observations": "observations"
};

final String medicalVisitJson = jsonEncode(medicalVisitMap);

final medicalVisit = MedicalVisit(
    specialist: "Mariana",
    address: "Alsina 1309, Quilmes",
    date: DateTime(2023, 03, 30),
    observations: "observations");

final pet = Pet.fromJson(petMap);

final Pet petWithMedicalVisits = Pet.fromJson(petMap)..addMedicalVisit(MedicalVisit.fromJson(medicalVisitMap));
