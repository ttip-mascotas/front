import 'package:equatable/equatable.dart';

class DoseControl extends Equatable {
  final int id;
  final DateTime time;
  final bool supplied;

  const DoseControl({
    required this.id,
    required this.time,
    required this.supplied,
  });

  DoseControl.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        time = json["time"],
        supplied = json["supplied"];

  @override
  List<Object?> get props => [
        id,
        time,
        supplied,
      ];
}