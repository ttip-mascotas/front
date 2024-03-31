import 'package:intl/intl.dart';
import 'package:mascotas/utils/format.dart';

class Pet {
  final int id;
  final String name;
  final int age;
  final double weight;
  final String photo;
  final DateTime birthdate;
  final String breed;
  final String fur;
  final String sex;

  const Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.photo,
    required this.birthdate,
    required this.breed,
    required this.fur,
    required this.sex,
  });

  Pet.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        age = json["age"],
        weight = json["weight"],
        photo = json["photo"],
        birthdate = DateFormat("yyyy-MM-dd").parse(json["birthdate"]),
        breed = json["breed"],
        fur = json["fur"],
        sex = json["sex"];

  String birthdateToString() {
    return formatDateToString(birthdate);
  }

  String ageToString() {
    return age.toString();
  }

  String weightToString() {
    return "${weight.ceil().toString()} Kg";
  }
}
