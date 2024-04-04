import 'package:equatable/equatable.dart';
import 'package:mascotas/model/medicalVisit.dart';
import 'package:mascotas/utils/format.dart';

class Pet extends Equatable {
  final int id;
  final String name;
  final int age;
  final double weight;
  final String photo;
  final DateTime birthdate;
  final String breed;
  final String fur;
  final String sex;
  final List<MedicalVisit> medicalVisits;

  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.photo,
    required this.birthdate,
    required this.breed,
    required this.fur,
    required this.sex,
    List<MedicalVisit>? medicalVisits,
  }) : medicalVisits = medicalVisits ?? [];

  Pet.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        age = json["age"],
        weight = json["weight"],
        photo = json["photo"],
        birthdate = formatStringToDateTimeFromBack(json["birthdate"]),
        breed = json["breed"],
        fur = json["fur"],
        sex = json["sex"],
        medicalVisits = _medicalVisitsFromJson(json["medicalVisits"]);

  static List<MedicalVisit> _medicalVisitsFromJson(List<dynamic> json) {
    return json
        .map<MedicalVisit>((json) => MedicalVisit.fromJson(json))
        .toList();
  }

  String birthdateToString() {
    return formatDateToString(birthdate);
  }

  String ageToString() {
    return age.toString();
  }

  String weightToString() {
    return "${weight.ceil().toString()} Kg";
  }

  void addMedicalVisit(MedicalVisit medicalVisit) {
    medicalVisits.add(medicalVisit);
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
      ];
}
