import "dart:convert";

import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/bloc/pets_bloc.dart";
import "package:mascotas/datasource/pets_datasource.dart";
import "package:mascotas/model/pet.dart";
import "package:mockito/mockito.dart";

import "../datasource/mocks.dart";
import "../datasource/pets_datasource_test.mocks.dart";

void main() {
  late MockApi mockApi;
  late PetsDatasource petsDataSource;

  setUp(() {
    mockApi = MockApi();
    petsDataSource = PetsDatasource(api: mockApi);
  });

  blocTest(
    "Al buscar todas las mascotas obtengo un listado con su información básica",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(petsJson, 200));
    },
    build: () => PetsCubit(petsDatasource: petsDataSource),
    act: (cubit) => cubit.getPets(),
    expect: () => [
      Loaded(value: [Pet.fromJson(jsonDecode(petJson))]),
    ],
  );

  blocTest(
    "Al buscar una mascota con un id algo sale mal y obtengo un error",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => throw Exception("Algo salió mal"));
    },
    build: () => PetsCubit(petsDatasource: petsDataSource),
    act: (cubit) => cubit.getPets(),
    expect: () => [Error(message: "Ocurrió un error inesperado")],
  );
}
