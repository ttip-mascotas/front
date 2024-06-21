import "dart:convert";

import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mascotas/bloc/analysis_bloc.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/datasource/analysis_datasource.dart";
import "package:mascotas/model/analysis.dart";
import "package:mockito/mockito.dart";

import "../datasource/mocks.dart";
import "../datasource/treatment_datasource_test.mocks.dart";

void main() {
  late MockApi mockApi;
  late AnalysisDatasource analysisDatasource;

  setUp(() {
    mockApi = MockApi();
    analysisDatasource = AnalysisDatasource(api: mockApi);
  });

  blocTest(
    "Al buscar un analisis con un id, obtengo el analisis con todas sus imagenes",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(analysisJson, 200));
    },
    build: () => AnalysisBloc(analysisDatasource: analysisDatasource, id: 1),
    expect: () => [
      Loaded(value: Analysis.fromJson(jsonDecode(analysisJson))),
    ],
  );

  blocTest(
    "Al buscar un analisis con un id algo sale mal y obtengo un error",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => throw Exception("Algo salió mal"));
    },
    build: () => AnalysisBloc(analysisDatasource: analysisDatasource, id: 1),
    expect: () => [Error(message: "Ocurrió un error inesperado")],
  );
}