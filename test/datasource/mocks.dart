import 'dart:convert';

import 'package:mascotas/model/medical_visit.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/model/treatment.dart';
import 'package:mascotas/utils/format.dart';

final Map<String, dynamic> petMap = {
  "id": 1,
  "name": "Lola",
  "photo": "",
  "age": 2,
  "weight": 35.0,
  "birthdate": "2023-03-30",
  "breed": "San Bernardo",
  "fur": "Largo",
  "sex": "FEMALE",
  "medicalVisits": []
};

final String petJson = jsonEncode(petMap);

final String petsJson = jsonEncode({
  "results": [petMap]
});

final Map<String, dynamic> medicalVisitMap = {
  "id": 1,
  "address": "Alsina 1309, Quilmes",
  "datetime": "2023-03-30",
  "specialist": "Mariana",
  "observations": "observations"
};

final String medicalVisitJson = jsonEncode(medicalVisitMap);

final medicalVisit = MedicalVisit(
  id: 1,
  specialist: "Mariana",
  address: "Alsina 1309, Quilmes",
  date: DateTime(2023, 03, 30),
  observations: "observations",
);

final pet = Pet.fromJson(petMap);

final Pet petWithMedicalVisits = Pet.fromJson(petMap)
  ..addMedicalVisit(MedicalVisit.fromJson(medicalVisitMap));

final dateTime = formatTimeOfDayToDateTime("05:20 AM");

final treatment = Treatment(
  id: 1,
  medicine: 'Tramadol',
  startDate: dateTime,
  dose: '1/4',
  numberOfTime: 10,
  frequency: 8,
);

final treatmentMap = {
  "id": 1,
  "medicine": "Tramadol",
  "dose": "1/4",
  "datetime": dateTime.toIso8601String(),
  "numberOfTimes": 10,
  "frequency": 8,
};

final String treatmentJson = jsonEncode(treatmentMap);

final Pet petWithTreatment = Pet.fromJson(petMap)..startTreatment(treatment);
