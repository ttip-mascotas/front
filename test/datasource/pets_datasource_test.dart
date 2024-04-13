import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mascotas/model/medical_visit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';
import 'pets_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Api>()])
void main() {
  late MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
  });

  test("Get a pet with a given id", () async {
    final PetsDatasource petsDataSource = PetsDatasource(api: mockApi);

    const petId = 1;

    when(mockApi.get("/pets/$petId"))
        .thenAnswer((_) async => Response(petJson, 200));

    final pet = await petsDataSource.getPet(petId);

    expect(pet.id, 1);
    expect(pet.name, "Lola");
    expect(pet.age, 2);
    expect(pet.weight, 35);
    expect(pet.birthdate, DateTime(2023, 03, 30));
    expect(pet.breed, "San Bernardo");
    expect(pet.fur, "Largo");
    expect(pet.sex, "Hembra");
  });

  test("Record pet medical visit", () async {
    final PetsDatasource petsDataSource = PetsDatasource(api: mockApi);

    final medicalVisit = MedicalVisit(
        specialist: "Mariana",
        address: "Alsina 1309, Quilmes",
        date: DateTime(2023, 03, 30),
        observations: "observations");

    const petId = 1;

    when(mockApi.post("/pets/$petId/medical-records",
            body: medicalVisit.toJson()))
        .thenAnswer((_) async => Response(medicalVisitJson, 200));

    final medicalVisitResponse =
        await petsDataSource.addMedicalVisit(medicalVisit, petId);

    expect(medicalVisitResponse.id, 1);
    expect(medicalVisitResponse.specialist, medicalVisitResponse.specialist);
    expect(medicalVisitResponse.date, medicalVisitResponse.date);
    expect(
        medicalVisitResponse.observations, medicalVisitResponse.observations);
    expect(medicalVisitResponse.address, medicalVisitResponse.address);
  });

  test("Get all pets", () async {
    final PetsDatasource petsDataSource = PetsDatasource(api: mockApi);

    when(mockApi.get("/pets")).thenAnswer((_) async => Response(petsJson, 200));

    final pets = await petsDataSource.getPets();

    expect(pets.length, 1);
    expect(pets[0].name, petMap['name']);
    expect(pets[0].medicalVisits, isEmpty);
  });

  test("Register pet", () async {
    final PetsDatasource petsDataSource = PetsDatasource(api: mockApi);

    when(mockApi.post("/pets", body: pet.toJson()))
        .thenAnswer((_) async => Response(petJson, 200));

    final petResponse = await petsDataSource.addPet(pet);

    expect(petResponse.id, 1);
    expect(petResponse.name, "Lola");
    expect(petResponse.age, 2);
    expect(petResponse.weight, 35);
    expect(petResponse.birthdate, DateTime(2023, 03, 30));
    expect(petResponse.breed, "San Bernardo");
    expect(petResponse.fur, "Largo");
    expect(petResponse.sex, "Hembra");
  });
}
