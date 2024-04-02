import 'package:mascotas/utils/format.dart';

class MedicalVisit {
  final int? id;
  final String specialist;
  final String address;
  final DateTime date;
  final String observations;

  const MedicalVisit({
    required this.specialist,
    required this.address,
    required this.date,
    required this.observations,
    this.id,
  });

  MedicalVisit.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        specialist = json['specialist'],
        address = json['address'],
        date = formatStringToDateTime(json['datetime']),
        observations = json['observations'];

  Map<String, dynamic> toJson() => {
        'specialist': specialist,
        'address': address,
        'datetime': date.toIso8601String(),
        'observations': observations,
      };
}
