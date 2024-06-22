import "dart:async";

import "package:mascotas/exception/datasource_exception.dart";
import "package:mascotas/model/analysis.dart";

import "datasource.dart";

class AnalysisDatasource extends BaseDatasource {
  AnalysisDatasource({required super.api});

  Future<Analysis> getAnalysis(int id) async {
    try {
      final response = await api.get("/analyses/$id");

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
