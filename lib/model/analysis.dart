import 'package:equatable/equatable.dart';
import 'package:mascotas/utils/format.dart';

class Analysis extends Equatable {
  final int? id;
  final String name;
  final int size;
  final DateTime createdAt;
  final String url;

  const Analysis({
    required this.name,
    required this.size,
    required this.createdAt,
    required this.url,
    this.id,
  });

  Analysis.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        size = json["size"],
        url = json["url"],
        createdAt = parseUTCDateTimeISO8601StringToLocal(json["createdAt"]);

  @override
  List<Object?> get props => [
        id,
        name,
        size,
        createdAt,
        url,
      ];
}
