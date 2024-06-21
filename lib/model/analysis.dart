import "package:equatable/equatable.dart";
import "package:mascotas/utils/format.dart";

class Analysis extends Equatable {
  final int? id;
  final String name;
  final int size;
  final DateTime createdAt;
  final String url;
  final List<AnalysisImage> images;

  Analysis({
    required this.name,
    required this.size,
    required this.createdAt,
    required this.url,
    List<AnalysisImage>? images,
    this.id,
  }) : images = images ?? [];

  Analysis.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        size = json["size"],
        url = json["url"],
        images = _imagesFromJson(json["images"]),
        createdAt = parseUTCDateTimeISO8601StringToLocal(json["createdAt"]);

  static List<AnalysisImage> _imagesFromJson(List<dynamic>? json) {
    if (json != null) {
      return json
          .map<AnalysisImage>((json) => AnalysisImage.fromJson(json))
          .toList();
    }
    return [];
  }

  @override
  List<Object?> get props => [
        id,
        name,
        size,
        createdAt,
        url,
      ];
}

class AnalysisImage {
  final int id;
  final String url;

  AnalysisImage({
    required this.url,
    required this.id,
  });

  factory AnalysisImage.fromJson(Map<String, dynamic> json) {
    return AnalysisImage(
      id: json["id"],
      url: json["url"],
    );
  }
}
