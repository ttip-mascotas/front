import "dart:convert";

import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/bloc/pet_bloc.dart";
import "package:mascotas/datasource/pets_datasource.dart";
import "package:mascotas/exception/datasource_exception.dart";
import "package:mascotas/model/pet.dart";
import "package:mascotas/utils/format.dart";
import "package:mockito/mockito.dart";

import "../datasource/mocks.dart";
import "../datasource/pets_datasource_test.mocks.dart";

void main() {
  late MockApi mockApi;
  late PetsDatasource petsDataSource;
  late MockNotifier notifier;
  const int petId = 1;

  setUp(() {
    mockApi = MockApi();
    notifier = MockNotifier();
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
    build: () => PetCubit(petsDatasource: petsDataSource, notifier: notifier),
    act: (cubit) => cubit.getPet(1),
    expect: () => [
      Loaded(value: Pet.fromJson(jsonDecode(petJson))),
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
    build: () => PetCubit(petsDatasource: petsDataSource, notifier: notifier),
    act: (cubit) => cubit.getPet(petId),
    expect: () => [Error(message: "Ocurrió un error inesperado")],
  );

  blocTest(
    "Al registrar una visita médica en una mascota con el id dado, obtengo ese registro",
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
    build: () => PetCubit(petsDatasource: petsDataSource, notifier: notifier)
      ..getPet(petId),
    act: (cubit) async {
      await cubit.getPet(petId);
      return await cubit.addMedicalVisit(
          specialist: medicalVisit.specialist,
          address: medicalVisit.address,
          date: formatDateToString(medicalVisit.date),
          observations: medicalVisit.observations);
    },
    expect: () => [
      Loaded(value: petWithMedicalVisits),
      Loading(),
      Loaded(value: petWithMedicalVisits),
    ],
  );

  blocTest(
    "Al registrar una visita médica en una mascota con el id dado algo sale mal y no se actualiza la mascota",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(petJson, 200));

      when(
        mockApi.post("/pets/$petId/medical-records",
            body: medicalVisit.toJson()),
      ).thenAnswer((_) async => throw Exception("Algo salió mal"));
    },
    build: () => PetCubit(petsDatasource: petsDataSource, notifier: notifier)
      ..getPet(petId),
    act: (cubit) async {
      await cubit.getPet(petId);
      return await cubit.addMedicalVisit(
          specialist: medicalVisit.specialist,
          address: medicalVisit.address,
          date: formatDateToString(medicalVisit.date),
          observations: medicalVisit.observations);
    },
    errors: () => [isA<DatasourceException>()],
    expect: () => [
      Loaded(value: pet),
    ],
  );

  blocTest(
    "Al iniciar un tramamiento para una mascota con el id dado, obtengo ese registro",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(petJson, 200));

      when(
        mockApi.post("/pets/$petId/treatments", body: treatment.toJson()),
      ).thenAnswer((_) async => Response(treatmentJson, 200));
    },
    build: () => PetCubit(petsDatasource: petsDataSource, notifier: notifier),
    act: (cubit) async {
      await cubit.getPet(petId);
      return await cubit.startTreatment(
          medicine: treatment.medicine,
          dose: treatment.dose,
          numberOfTime: treatment.numberOfTime.toString(),
          frequency: treatment.frequency.toDouble(),
          time: "5:20 AM");
    },
    expect: () => [
      Loaded(value: petWithTreatment),
      Loading(),
      Loaded(value: petWithTreatment),
    ],
  );

  blocTest(
    "Al iniciar un tramamiento para una mascota con el id dado algo sale mal y no se actualiza la mascota",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(petJson, 200));

      when(
        mockApi.post("/pets/$petId/treatments", body: treatment.toJson()),
      ).thenAnswer((_) async => throw Exception("Algo salió mal"));
    },
    build: () => PetCubit(petsDatasource: petsDataSource, notifier: notifier),
    act: (cubit) async {
      await cubit.getPet(petId);
      return await cubit.startTreatment(
          medicine: treatment.medicine,
          dose: treatment.dose,
          numberOfTime: treatment.numberOfTime.toString(),
          frequency: treatment.frequency.toDouble(),
          time: "5:20 AM");
    },
    errors: () => [isA<DatasourceException>()],
    expect: () => [
      Loaded(value: pet),
    ],
  );
}
