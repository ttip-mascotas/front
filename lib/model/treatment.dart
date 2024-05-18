import 'package:equatable/equatable.dart';
import 'package:mascotas/model/schedule_per_day.dart';
import 'package:mascotas/utils/format.dart';

class Treatment extends Equatable {
  final int? id;
  final DateTime startDate;
  final String dose;
  final String medicine;
  final int numberOfTime;
  final int frequency;
  final List<SchedulePerDay> schedulesPerDay;

  Treatment({
    this.id,
    required this.medicine,
    required this.startDate,
    required this.dose,
    required this.numberOfTime,
    required this.frequency,
    List<SchedulePerDay>? schedulesPerDay,
  }) : schedulesPerDay = schedulesPerDay ?? [];

  Treatment.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        medicine = json["medicine"],
        dose = json["dose"],
        startDate = formatDateTimeStringToDateTimeFromBack(json["datetime"]),
        numberOfTime = json["numberOfTimes"],
        frequency = json["frequency"],
        schedulesPerDay = _schedulesPerDayFromJson(json["schedulesPerDay"]);

  static List<SchedulePerDay> _schedulesPerDayFromJson(List<dynamic>? json) {
    if (json != null) {
      return json
          .map<SchedulePerDay>((json) => SchedulePerDay.fromJson(json))
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
        schedulesPerDay,
      ];
}
