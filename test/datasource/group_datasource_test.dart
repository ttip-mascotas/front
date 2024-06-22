import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mascotas/datasource/group_datasource.dart";
import "package:mascotas/model/group.dart";
import "package:mockito/mockito.dart";

import "mocks.dart";
import "pets_datasource_test.mocks.dart";

void main() {

  late MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
  });

  test("Get a group with its pets", () async {
    final GroupDatasource groupDatasource = GroupDatasource(api: mockApi);

    when(mockApi.get("/groups/1")).thenAnswer((_) async => Response(groupJson, 200));

    final Group group = await groupDatasource.getGroup(1);

    expect(group.name, "Mi grupo");
    expect(group.pets.length, 1);
    expect(group.pets[0].name, petMap["name"]);
    expect(group.pets[0].medicalVisits, isEmpty);
  });

  test("Register pet", () async {
    final GroupDatasource groupDataSource = GroupDatasource(api: mockApi);

    when(mockApi.post("groups/1/pets", body: pet.toJson()))
        .thenAnswer((_) async => Response(petJson, 200));

    final petResponse = await groupDataSource.addPet(pet, 1);

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