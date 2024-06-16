import 'package:equatable/equatable.dart';
import 'package:mascotas/utils/format.dart';

class TreatmentLog extends Equatable {
  final int id;
  final DateTime datetime;
  bool administered;

  TreatmentLog({
    required this.id,
    required this.datetime,
    required this.administered,
  });

  TreatmentLog.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        datetime = parseUTCDateTimeISO8601StringToLocal(json["datetime"]),
        administered = json["administered"];

  @override
  List<Object?> get props => [
        id,
        datetime,
        administered,
      ];

  void check() {
    administered = !administered;
  }
}
