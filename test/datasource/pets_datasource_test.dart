import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pets_datasource_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<Api>()])

void main() {
  late MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
  });


  test("Hello world", () async {
    final PetsDatasource petsDataSource = PetsDatasource(api: mockApi);

    when(mockApi.get("/pets"))
        .thenAnswer((_) async => Response("hello world", 200));


    final response = await petsDataSource.getPets();

    expect(response, "hello world");
  });
}