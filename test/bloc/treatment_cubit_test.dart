import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/bloc/treatment_cubit.dart';
import 'package:mascotas/datasource/treatment_datasource.dart';
import 'package:mascotas/model/treatment.dart';
import 'package:mockito/mockito.dart';

import '../datasource/mocks.dart';
import '../datasource/pets_datasource_test.mocks.dart';

void main() {
  late MockApi mockApi;
  late TreatmentsDatasource treatmentDatasource;

  setUp(() {
    mockApi = MockApi();
    treatmentDatasource = TreatmentsDatasource(api: mockApi);
  });

  blocTest(
    "Al buscar un tratamiento obtengo el tratamiento",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(treatmentJson, 200));
    },
    build: () => TreatmentCubit(treatmentsDatasource: treatmentDatasource),
    act: (cubit) => cubit.getTreatment(1),
    expect: () => [
      Loaded(value: Treatment.fromJson(jsonDecode(treatmentJson))),
    ],
  );

  blocTest(
    "Al buscar un tratamiento con un id algo sale mal y obtengo un error",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => throw Exception("Algo salió mal"));
    },
    build: () => TreatmentCubit(treatmentsDatasource: treatmentDatasource),
    act: (cubit) => cubit.getTreatment(99),
    expect: () => [Error(message: "Ocurrió un error inesperado")],
  );

  blocTest(
    "Al registrar el avance de un tratamiento obtengo el tratamiento con el check",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(treatmentWithLogJson, 200));
      when(
        mockApi.post(
          any,
        ),
      ).thenAnswer((_) async => Response(treatmentLogJson, 200));
    },
    build: () => TreatmentCubit(treatmentsDatasource: treatmentDatasource)..getTreatment(1),
    act: (cubit) => cubit.checkTreatmentLog(1),
    expect: () => [
      Loaded(value: Treatment.fromJson(jsonDecode(treatmentWithLogJson))),
    ],
  );

  blocTest(
    "Al registrar el avance de un tratamiento algo sale mal y obtengo un error",
    setUp: () {
      when(mockApi.get("/treatments/1"))
          .thenAnswer((_) async => Response(treatmentWithLogJson, 200));
      when(mockApi.put(
        "/treatments/1/logs/1",
        body: {'administered': false},
      )).thenAnswer((_) async => throw Exception("Algo salió mal"));
    },
    build: () => TreatmentCubit(treatmentsDatasource: treatmentDatasource),
    act: (cubit) async {
      await cubit.getTreatment(1);
      await cubit.checkTreatmentLog(1);
    },
    expect: () => [
      Loaded(value: Treatment.fromJson(jsonDecode(treatmentWithLogJson))),
      Error(message: "Ocurrió un error inesperado"),
    ],
  );
}
