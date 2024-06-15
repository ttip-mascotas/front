import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/websocket_state.dart';
import 'package:mascotas/datasource/treatment_datasource.dart';
import 'package:mascotas/datasource/web_socket_datasource.dart';
import 'package:mascotas/exception/datasource_exception.dart';
import 'package:mascotas/model/treatment.dart';
import 'package:mascotas/model/treatment_log.dart';

class WebSocketBloc extends Cubit<WebSocketState> {
  final WebSocketDatasource repository;
  final TreatmentsDatasource treatmentsDatasource;

  WebSocketBloc({
    required this.repository,
    required this.treatmentsDatasource,
    required int id,
  }) : super(WebSocketInitial()) {
    setupWebSocketListener(id);
  }

  Future<void> setupWebSocketListener(int id) async {
    try {
      final treatment = await treatmentsDatasource.getTreatment(id);
      await repository.connectWebSocket(
        (treatmentUpdated) {
          emit(WebSocketTreatmentReceived(treatmentUpdated));
        },
        id
      );
      emit(WebSocketTreatmentReceived(treatment));
    } on DatasourceException catch (error) {
      emit(WebSocketError(error.message));
    } catch (e) {
      debugPrint(e.toString());
      emit(WebSocketError('Ocurrió un error inesperado'));
    }
  }

  void closeWebSocket() {
    repository.closeWebSocket();
    emit(WebSocketClosed());
  }

  Future<void> checkTreatmentLog({required int treatmentLogId}) async {
    try {
      if (state is WebSocketTreatmentReceived) {
        final WebSocketTreatmentReceived currentState =
        state as WebSocketTreatmentReceived;
        final Treatment treatment = currentState.treatment;
        final TreatmentLog treatmentLog =
        treatment.findTreatmentLogWithId(treatmentLogId);

        repository.checkTreatmentLog(
          treatment.id!,
          treatmentLogId,
          !treatmentLog.administered,
        );
      }
    } catch (error) {
      debugPrint(error.toString());
      emit(WebSocketError("Ocurrió un error inesperado"));
    }

  }
}
