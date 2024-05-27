import 'package:equatable/equatable.dart';
import 'package:mascotas/model/treatment_log.dart';
import 'package:mascotas/utils/format.dart';

class Treatment extends Equatable {
  final int? id;
  final DateTime startDate;
  final String dose;
  final String medicine;
  final int numberOfTime;
  final int frequency;
  final List<TreatmentLog> logs;

  Treatment({
    this.id,
    required this.medicine,
    required this.startDate,
    required this.dose,
    required this.numberOfTime,
    required this.frequency,
    List<TreatmentLog>? logs,
  }) : logs = logs ?? [];

  Treatment.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        medicine = json["medicine"],
        dose = json["dose"],
        startDate = parseDateTimeStringAsDateTimeFromBack(json["datetime"]),
        numberOfTime = json["numberOfTimes"],
        frequency = json["frequency"],
        logs = _logsFromJson(json["logs"]);

  static List<TreatmentLog> _logsFromJson(List<dynamic>? json) {
    if (json != null) {
      return json
          .map<TreatmentLog>((json) => TreatmentLog.fromJson(json))
          .toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() => {
        "medicine": medicine,
        "dose": dose,
        "datetime": startDate.toIso8601String(),
        "numberOfTimes": numberOfTime,
        "frequency": frequency,
      };

  @override
  List<Object?> get props => [
        id,
        startDate,
        dose,
        medicine,
        numberOfTime,
        frequency,
        logs,
      ];
}
