import "package:equatable/equatable.dart";
import "package:mascotas/model/analysis.dart";
import "package:mascotas/model/medical_visit.dart";
import "package:mascotas/model/treatment.dart";
import "package:mascotas/utils/format.dart";

class Pet extends Equatable {
  final int? id;
  final String name;
  final int age;
  final double weight;
  final String photo;
  final DateTime birthdate;
  final String breed;
  final String fur;
  final String sex;
  final List<MedicalVisit> medicalVisits;
  final List<Treatment> treatments;
  final List<Analysis> analyses;

  Pet({
    this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.photo,
    required this.birthdate,
    required this.breed,
    required this.fur,
    required this.sex,
    List<MedicalVisit>? medicalVisits,
    List<Treatment>? treatments,
    List<Analysis>? analyses,
  })  : medicalVisits = medicalVisits ?? [],
        treatments = [],
        analyses = [];

  Pet.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        age = json["age"],
        weight = json["weight"],
        photo = json["photo"],
        birthdate = parseUTCDateTimeISO8601StringToLocal(json["birthdate"]),
        breed = json["breed"],
        fur = json["fur"],
        sex = typeOfSex[json["sex"]] ?? "",
        medicalVisits = _medicalVisitsFromJson(json["medicalVisits"]),
        treatments = _treatmentFromJson(json["treatments"]),
        analyses = _analysesFromJson(json["analyses"]);

  static List<MedicalVisit> _medicalVisitsFromJson(List<dynamic>? json) {
    if (json != null) {
      return json
          .map<MedicalVisit>((json) => MedicalVisit.fromJson(json))
          .toList();
    }
    return [];
  }

  static List<Treatment> _treatmentFromJson(List<dynamic>? json) {
    if (json != null) {
      return json.map<Treatment>((json) => Treatment.fromJson(json)).toList();
    }
    return [];
  }

  static List<Analysis> _analysesFromJson(List<dynamic>? json) {
    if (json != null) {
      return json.map<Analysis>((json) => Analysis.fromJson(json)).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "weight": weight,
        "photo": photo,
        "birthdate": convertLocalDateTimeToIso8601UTCString(birthdate),
        "breed": breed,
        "fur": fur,
        "sex": sex,
      };

  void addMedicalVisit(MedicalVisit medicalVisit) {
    medicalVisits.add(medicalVisit);
  }

  void startTreatment(Treatment treatment) {
    treatments.add(treatment);
  }

  void addAnalysis(Analysis analysis) {
    analyses.add(analysis);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        weight,
        photo,
        birthdate,
        breed,
        fur,
        sex,
        medicalVisits,
        treatments,
        analyses,
      ];
}

final Map<String, String> typeOfSex = {
  PetSex.female.name.toUpperCase(): "Hembra",
  PetSex.male.name.toUpperCase(): "Macho",
};

enum PetSex {
  female,
  male,
}
