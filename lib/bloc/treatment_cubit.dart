import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/datasource/treatment_datasource.dart';
import 'package:mascotas/exception/datasource_exception.dart';

class TreatmentCubit extends Cubit<BlocState> {
  final TreatmentsDatasource treatmentsDatasource;

  TreatmentCubit({required this.treatmentsDatasource}) : super(Loading());

  Future<void> getTreatment(int id) async {
    emit(Loading());
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
}
