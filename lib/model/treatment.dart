import 'package:mascotas/utils/format.dart';

class Treatment {
  final int? id;
  final DateTime startDate;
  final String dose;
  final String medicine;
  final int numberOfTime;
  final int frequency;

  Treatment({
    this.id,
    required this.medicine,
    required this.startDate,
    required this.dose,
    required this.numberOfTime,
    required this.frequency,
  });

  Map<String, dynamic> toJson() => {
        'medicine': medicine,
        'dose': dose,
        'datetime': startDate.toIso8601String(),
        'numberOfTimes': numberOfTime,
        'frequency': frequency,
      };

  Treatment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        medicine = json['medicine'],
        dose = json['dose'],
        startDate = formatStringToDateTimeFromBack(json['datetime']),
        numberOfTime = json['numberOfTimes'],
        frequency = json['frequency'];
}
