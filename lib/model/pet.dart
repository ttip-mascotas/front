import 'package:intl/intl.dart';

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
      : id = json["id"] as int,
        name = json["name"] as String,
        age = json["age"] as int,
        weight = json["weight"] as double,
        photo = json["photo"] as String,
        birthdate = DateFormat("yyyy-mm-dd").parse(json["birthdate"]),
        breed = json["breed"] as String,
        fur = json["fur"] as String,
        sex = json["sex"] as String;
}
