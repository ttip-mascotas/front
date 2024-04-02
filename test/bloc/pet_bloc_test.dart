import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/utils/format.dart';
import 'package:mockito/mockito.dart';
import '../datasource/mocks.dart';
import '../datasource/pets_datasource_test.mocks.dart';

void main() {
  late MockApi mockApi;
  late PetsDatasource petsDataSource;
  const int petId = 1;

  setUp(() {
    mockApi = MockApi();
    petsDataSource = PetsDatasource(api: mockApi);
  });

  blocTest(
    "Al buscar una mascota con un id obtengo su información",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(petJson, 200));
    },
    build: () => PetCubit(petsDatasource: petsDataSource),
    act: (cubit) => cubit.getPet(1),
    expect: () => [
      Loaded(pet: Pet.fromJson(jsonDecode(petJson))),
    ],
  );

  blocTest(
    "Al buscar una mascota con un id algo sale mal y obtengo un error",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => throw Exception("Algo salio mal"));
    },
    build: () => PetCubit(petsDatasource: petsDataSource),
    act: (cubit) => cubit.getPet(petId),
    expect: () => [
      Error(message: "Ocurrio un error inesperado")
    ],
  );

  blocTest(
    "Al registrar una visita medica en una mascota con el id dado, obtengo ese registro",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(petJson, 200));

      when(
        mockApi.post("/pets/$petId/medical-records",
            body: medicalVisit.toJson()),
      ).thenAnswer((_) async => Response(medicalVisitJson, 200));
    },
    build: () => PetCubit(petsDatasource: petsDataSource)..getPet(petId),
    act: (cubit) async {
      await cubit.getPet(petId);
      return await cubit.addMedicalVisit(
          specialist: medicalVisit.specialist,
          address: medicalVisit.address,
          date: formatDateToString(medicalVisit.date),
          observations: medicalVisit.observations);
    },
    expect: () => [
      Loaded(pet: petWithMedicalVisits),
      Loading(),
      Loaded(pet: petWithMedicalVisits),
    ],
  );

  blocTest(
    "Al registrar una visita medica en una mascota con el id dado algo sale mal y obtengo un error",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(petJson, 200));

      when(
        mockApi.post("/pets/$petId/medical-records",
            body: medicalVisit.toJson()),
      ).thenAnswer((_) async => throw Exception("Algo salio mal"));
    },
    build: () => PetCubit(petsDatasource: petsDataSource)..getPet(petId),
    act: (cubit) async {
      await cubit.getPet(petId);
      return await cubit.addMedicalVisit(
          specialist: medicalVisit.specialist,
          address: medicalVisit.address,
          date: formatDateToString(medicalVisit.date),
          observations: medicalVisit.observations);
    },
    expect: () => [
      Loaded(pet: pet),
      Loading(),
      Error(message: "Ocurrio un error inesperado"),
    ],
  );
}
