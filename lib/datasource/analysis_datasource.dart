import "dart:async";

import "package:mascotas/exception/datasource_exception.dart";
import "package:mascotas/model/analysis.dart";

import "datasource.dart";

class AnalysisDatasource extends BaseDatasource {
  AnalysisDatasource({required super.api});

  Future<Analysis> getAnalysis(int id) async {
    // TODO: descomentar cuando esta listo el endpoint
    return Analysis(
        name: "Informe",
        size: 123,
        createdAt: DateTime.now(),
        url: "",
        images: [
          AnalysisImage(
              url:
                  "http://10.0.2.2:9000/public/2887b03c-20ff-4ac9-aed7-1f2a979a8e61",
              id: 1),
          AnalysisImage(
              url:
              "http://10.0.2.2:9000/public/2887b03c-20ff-4ac9-aed7-1f2a979a8e61",
              id: 2),
          AnalysisImage(
              url:
              "http://10.0.2.2:9000/public/2887b03c-20ff-4ac9-aed7-1f2a979a8e61",
              id: 3),
        ]);
    try {
      final response = await api.get("/analysis/$id");

      return super.manageResponse<Analysis>(
        response,
        parseJson: (json) => Analysis.fromJson(json),
        message: "Hubo un error al cargar la información del análisis",
      );
    } on TimeoutException {
      return throw DatasourceException(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    }
  }
}
