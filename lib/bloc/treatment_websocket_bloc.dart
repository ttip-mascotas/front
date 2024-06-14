import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/websocket_state.dart';
import 'package:mascotas/datasource/treatment_datasource.dart';
import 'package:mascotas/datasource/web_socket_controller.dart';
import 'package:mascotas/model/treatment.dart';

class WebSocketBloc extends Cubit<WebSocketState> {
  final WebSocketController webSocketController;
  final TreatmentsDatasource treatmentsDatasource;

  WebSocketBloc({
    required this.webSocketController,
    required this.treatmentsDatasource,
    required int id,
  }) : super(WebSocketInitial()) {
    setupWebSocketListener(id);
  }

  Future<void> setupWebSocketListener(int id) async {
    try {
      final treatment = await treatmentsDatasource.getTreatment(id);
      await webSocketController.openWebSocket(
        (treatmentLog) {
          // TODO: cuando el endpoint devuelva el treatment hay que actualizar el estado del Cubit
          debugPrint('Conectado ${treatmentLog.administered}');
        },
        id,
        //TODO: cambiar cuando esté listo el endpoint
        treatment.logs.first.id,
      );
      emit(WebSocketTreatmentReceived(treatment));
    } catch (e) {
      debugPrint(e.toString());
      emit(WebSocketError('No se pudo conectar al websocket'));
    }
  }

  void closeWebSocket() {
    webSocketController.closeWebSocket();
    emit(WebSocketClosed());
  }

  Future<void> checkTreatmentLog({required int treatmentLogId}) async {
    if (state is WebSocketTreatmentReceived) {
      final WebSocketTreatmentReceived currentState =
          state as WebSocketTreatmentReceived;
      final Treatment treatment = currentState.treatment;

      // TODO: cambiar cuando esté listo el endpoint
      webSocketController.checkTreatmentLog(
        treatment.id!,
        treatment.logs.first.id,
        !treatment.logs.first.administered,
      );
    }
  }
}
