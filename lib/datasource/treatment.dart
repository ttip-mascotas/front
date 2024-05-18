import 'dart:async';

import 'package:mascotas/datasource/datasource.dart';
import 'package:mascotas/exception/datasource_exception.dart';
import 'package:mascotas/model/treatment.dart';

class TreatmentsDatasource extends BaseDatasource {
  TreatmentsDatasource({required super.api});

  Future<Treatment> getTreatment(int id) async {
    try {
      final response = await api.get("/treatments/$id");

      return super.manageResponse<Treatment>(
        response,
        parseJson: (json) => Treatment.fromJson(json),
        message: "Hubo un error al cargar la información del tratamiento",
      );
    } on TimeoutException {
      return throw DatasourceException(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    }
  }
}
