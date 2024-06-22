import "dart:convert";

import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/bloc/group_bloc.dart";
import "package:mascotas/datasource/group_datasource.dart";
import "package:mascotas/model/group.dart";
import "package:mockito/mockito.dart";
import "../datasource/mocks.dart";
import "../datasource/pets_datasource_test.mocks.dart";

void main() {
  late MockApi mockApi;
  late GroupDatasource groupDatasource;

  setUp(() {
    mockApi = MockApi();
    groupDatasource = GroupDatasource(api: mockApi);
  });

  blocTest(
    "Al buscar un grupo con un id, obtengo el grupo con todas las mascotas",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(groupJson, 200));
    },
    build: () => GroupCubit(groupDatasource: groupDatasource),
    act: (cubit) => cubit.getGroup(1),
    expect: () => [
      Loaded(value: Group.fromJson(jsonDecode(groupJson))),
    ],
  );

  blocTest(
    "Al buscar un grupo con un id algo sale mal y obtengo un error",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => throw Exception("Algo salió mal"));
    },
    build: () => GroupCubit(groupDatasource: groupDatasource),
    act: (cubit) => cubit.getGroup(1),
    expect: () => [Error(message: "Ocurrió un error inesperado")],
  );
}
