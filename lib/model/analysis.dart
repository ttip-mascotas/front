import 'package:equatable/equatable.dart';
import 'package:mascotas/utils/format.dart';

class Analysis extends Equatable {
  final int? id;
  final String name;
  final int size;
  final DateTime createdAt;

  const Analysis({
    required this.name,
    required this.size,
    required this.createdAt,
    this.id,
  });

  Analysis.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        size = json['size'],
        createdAt = parseDateTimeStringAsDateTimeFromBack(json['createdAt']);

  @override
  List<Object?> get props => [
        id,
        name,
        size,
        createdAt,
      ];
}
