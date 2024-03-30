import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pets_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Api>()])
void main() {
  late MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
  });

  test("Get a pet with a given id", () async {
    final PetsDatasource petsDataSource = PetsDatasource(api: mockApi);
    final path =
        "${Directory.current.path}/test/datasource/get_pet_response_mock.json";
    final json = File(path).readAsStringSync();

    const petId = 1;

    when(mockApi.get("/pets/$petId"))
        .thenAnswer((_) async => Response(json, 200));

    final pet = await petsDataSource.getPet(petId);

    expect(pet.id, 1);
    expect(pet.name, "Lola");
    expect(pet.age, 2);
    expect(pet.weight, 35);
    expect(pet.birthdate, DateTime(2023, 03, 30));
    expect(pet.breed, "San Bernardo");
    expect(pet.fur, "Largo");
    expect(pet.sex, "FEMALE");
  });
}
