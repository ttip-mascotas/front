import 'dart:async';
import 'package:mascotas/datasource/web_socket_datasource.dart';
import 'package:mascotas/model/treatment_log.dart';

class WebSocketController {
  final WebSocketDatasource repository;

  WebSocketController({required this.repository});

  Future<void> openWebSocket(
      Function(TreatmentLog location) onTreatmentReceived, int treatmentId, int treatmentLogId) async {
    await repository.connectWebSocket(onTreatmentReceived, treatmentId, treatmentLogId);
  }

  Future<void> closeWebSocket() async {
    await repository.closeWebSocket();
  }

  void checkTreatmentLog(int treatmentId, int treatmentLogId, bool administrated) {
    repository.checkTreatmentLog(treatmentId, treatmentLogId, administrated);
  }
}
