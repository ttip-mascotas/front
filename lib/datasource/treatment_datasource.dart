import 'dart:async';

import 'package:mascotas/datasource/datasource.dart';
import 'package:mascotas/exception/datasource_exception.dart';
import 'package:mascotas/model/treatment.dart';
import 'package:mascotas/model/treatment_log.dart';

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

  Future<TreatmentLog> checkTreatmentLog(int id, int treatmentLogId, bool administered) async {
    try {
      final body = {
        'administered': administered,
      };

      final response = await api.put(
        "/treatments/$id/logs/$treatmentLogId",
        body: body,
      );

      return super.manageResponse<TreatmentLog>(
        response,
        parseJson: (json) => TreatmentLog.fromJson(json),
        message: "Hubo un error al registrar el avance del tratamiento",
      );
    } on TimeoutException {
      return throw DatasourceException(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    }
  }
}
