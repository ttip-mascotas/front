import 'package:equatable/equatable.dart';
import 'package:mascotas/model/dose_control.dart';
import 'package:mascotas/utils/format.dart';

class SchedulePerDay extends Equatable {
  final int id;
  final DateTime date;
  final List<DoseControl> doseControls;

  SchedulePerDay({
    required this.id,
    required this.date,
    List<DoseControl>? doseControls,
  }) : doseControls = doseControls ?? [];

  SchedulePerDay.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        date = parseDateTimeStringAsDateTimeFromBack(json["date"]),
        doseControls = _doseControlsFromJson(json["doseControls"]);

  static List<DoseControl> _doseControlsFromJson(List<dynamic>? json) {
    if (json != null) {
      return json
          .map<DoseControl>((json) => DoseControl.fromJson(json))
          .toList();
    }
    return [];
  }

  @override
  List<Object?> get props => [
        id,
        date,
        doseControls,
      ];
}
