import "dart:convert";

import "package:mascotas/model/analysis.dart";
import "package:mascotas/model/group.dart";
import "package:mascotas/model/medical_visit.dart";
import "package:mascotas/model/pet.dart";
import "package:mascotas/model/treatment.dart";
import "package:mascotas/model/treatment_log.dart";
import "package:mascotas/model/user.dart";
import "package:mascotas/utils/format.dart";

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

final dateTime = parseTimeStringAsDateTime("05:20 AM");

final treatment = Treatment(
  id: 1,
  medicine: "Tramadol",
  startDate: dateTime,
  dose: "1/4",
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
  "logs": [],
};

final String treatmentJson = jsonEncode(treatmentMap);

final Pet petWithTreatment = Pet.fromJson(petMap)..startTreatment(treatment);

final analysis = Analysis(
  id: 1,
  name: "ejemplo.pdf",
  size: 1,
  createdAt: DateTime(2023, 1, 1),
  url: "example.com",
);

final analysisMap = {
  "results": [
    {
      "id": 1,
      "name": "ejemplo.pdf",
      "size": 1,
      "createdAt": DateTime(2023, 1, 1).toIso8601String(),
      "url": "example.com",
    }
  ]
};

final String analysisJson = jsonEncode(analysisMap);

final treatmentLog = TreatmentLog(
  id: 1,
  datetime: DateTime(2023, 1, 1),
  administered: true,
);

final treatmentLogMap = {
  "id": 1,
  "datetime": DateTime(2023, 1, 1).toIso8601String(),
  "administered": true,
};

final String treatmentLogJson = jsonEncode(treatmentLogMap);

final treatmentWithLogMap = {
  "id": 1,
  "medicine": "Tramadol",
  "dose": "1/4",
  "datetime": dateTime.toIso8601String(),
  "numberOfTimes": 10,
  "frequency": 8,
  "logs": [
    treatmentLogMap,
  ],
};

final String treatmentWithLogJson = jsonEncode(treatmentWithLogMap);

final Treatment treatmentWithTreatmentLog = Treatment.fromJson(treatmentLogMap);

const group = Group(id: 1, name: "Mi grupo", members: [], pets: []);

final groupMap = {
  "id": 1,
  "name": "Mi grupo",
  "members": [],
  "pets": [
    petMap,
  ],
};

final groupListMap = {
  "results": [
    {
      "id": 1,
      "name": "Mi grupo",
      "members": [],
      "pets": [
        petMap,
      ],
    }
  ]
};

final String groupJson = jsonEncode(groupMap);

final String groupListJson = jsonEncode(groupListMap);

const user = User(id: 1, name: "Ximena", email: "email");

final userMap = {
  "id": 1,
  "name": "Ximena",
  "email": "email",
};

final String userJson = jsonEncode(userMap);
