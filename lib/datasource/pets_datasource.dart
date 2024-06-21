import "dart:async";
import "dart:io";

import "package:http_parser/http_parser.dart";
import "package:mascotas/datasource/datasource.dart";
import "package:mascotas/exception/datasource_exception.dart";
import "package:mascotas/model/analysis.dart";
import "package:mascotas/model/medical_visit.dart";
import "package:mascotas/model/pet.dart";
import "package:mascotas/model/treatment.dart";

class PetsDatasource extends BaseDatasource {
  PetsDatasource({required super.api});

  Future<Pet> getPet(int id) async {
    try {
      final response = await api.get("/pets/$id");

      return super.manageResponse<Pet>(
        response,
        parseJson: (json) => Pet.fromJson(json),
        message: "Hubo un error al cargar la información de la mascota",
      );
    } on TimeoutException {
      return throw DatasourceException(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    }
  }

  Future<MedicalVisit> addMedicalVisit(
      MedicalVisit medicalVisit, int id) async {
    final body = medicalVisit.toJson();
    final response = await api.post("/pets/$id/medical-records", body: body);

    return super.manageResponse<MedicalVisit>(response,
        parseJson: (json) => MedicalVisit.fromJson(json),
        message: "Hubo un problema al registrar la visita médica");
  }

  Future<Treatment> startTreatment(Treatment treatment, int id) async {
    final body = treatment.toJson();
    final response = await api.post(
      "/pets/$id/treatments",
      body: body,
    );

    return super.manageResponse<Treatment>(response,
        parseJson: (json) => Treatment.fromJson(json),
        message: "Hubo un problema al iniciar el tratamiento");
  }

  Future<Analysis> uploadAnalysis(File file, int petId) async {
    final response = await api.upload("/pets/$petId/analyses",
        file: file,
        field: "analysis",
        contentType: MediaType("application", "pdf"));

    return super.manageResponse<Analysis>(response,
        parseJson: (json) => Analysis.fromJson(json),
        message: "Hubo un problema al guardar el archivo");
  }

  Future<List<Analysis>> searchAnalysis(String text, int petId) async {
    final response =
        await api.get("/pets/$petId/analyses", queryParameters: {"q": text});

    return super.manageResponse<List<Analysis>>(response,
        parseJson: (json) => json["results"]
            .map<Analysis>((json) => Analysis.fromJson(json))
            .toList(),
        message: "Hubo un problema al obtener los análisis");
  }
}
