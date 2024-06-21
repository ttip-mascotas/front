import "dart:convert";

import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/bloc/groups_bloc.dart";
import "package:mascotas/datasource/user_datasource.dart";
import "package:mascotas/model/group.dart";
import "package:mockito/mockito.dart";

import "../datasource/mocks.dart";
import "../datasource/pets_datasource_test.mocks.dart";

void main() {
  late MockApi mockApi;
  late UserDatasource usersDatasource;

  setUp(() {
    mockApi = MockApi();
    usersDatasource = UserDatasource(api: mockApi);
  });

  blocTest(
    "Obtengo el listado de grupos de un usuario",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => Response(groupListJson, 200));
    },
    build: () => GroupsBloc(usersDatasource: usersDatasource),
    act: (cubit) => cubit.getGroups(userId: 1),
    expect: () => [
      Loaded(value: [Group.fromJson(jsonDecode(groupJson))]),
    ],
  );

  blocTest(
    "Al buscar el listado de grupos de un usuario, algo sale mal y obtengo un error",
    setUp: () {
      when(
        mockApi.get(
          any,
        ),
      ).thenAnswer((_) async => throw Exception("Algo salió mal"));
    },
    build: () => GroupsBloc(usersDatasource: usersDatasource),
    act: (cubit) => cubit.getGroups(userId: 1),
    expect: () => [Error(message: "Ocurrió un error inesperado")],
  );
}