import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/datasource/treatment_datasource.dart';
import 'package:mascotas/exception/datasource_exception.dart';
import 'package:mascotas/model/treatment.dart';
import 'package:mascotas/model/treatment_log.dart';

class TreatmentCubit extends Cubit<BlocState> {
  final TreatmentsDatasource treatmentsDatasource;

  TreatmentCubit({required this.treatmentsDatasource}) : super(Loading());

  Future<void> getTreatment(int id) async {
    try {
      final treatment = await treatmentsDatasource.getTreatment(id);
      emit(Loaded(value: treatment));
    } on DatasourceException catch (error) {
      emit(Error(message: error.message));
    } catch (error) {
      debugPrint(error.toString());
      emit(Error(message: "Ocurrió un error inesperado"));
    }
  }

  Future<void> checkTreatmentLog(int treatmentLogId) async {
    try {
      if (state is Loaded) {
        final Loaded currentState = state as Loaded;
        final Treatment treatment = currentState.value;
        emit(Loading());
        final TreatmentLog treatmentLog = treatment.logs
            .firstWhere((treatmentLog) => treatmentLog.id == treatmentLogId);
        final treatmentResponse = await treatmentsDatasource.checkTreatmentLog(
          treatment.id!,
          treatmentLog.id,
          !treatmentLog.administered
        );
        emit(Loaded(value: treatmentResponse));
      }
    } on DatasourceException catch (error) {
      emit(Error(message: error.message));
    } catch (error) {
      debugPrint(error.toString());
      emit(Error(message: "Ocurrió un error inesperado"));
    }
  }
}
