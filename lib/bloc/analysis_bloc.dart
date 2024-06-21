import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:mascotas/datasource/analysis_datasource.dart";
import "package:mascotas/exception/datasource_exception.dart";

import "bloc_state.dart";

class AnalysisBloc extends Cubit<BlocState> {
  final AnalysisDatasource analysisDatasource;

  AnalysisBloc({required this.analysisDatasource, required int id})
      : super(Loading()) {
    getAnalysis(id);
  }

  Future<void> getAnalysis(int id) async {
    try {
      final analysis = await analysisDatasource.getAnalysis(id);
      emit(Loaded(value: analysis));
    } on DatasourceException catch (error) {
      emit(Error(message: error.message));
    } catch (error) {
      debugPrint(error.toString());
      emit(Error(message: "Ocurrió un error inesperado"));
    }
  }
}
