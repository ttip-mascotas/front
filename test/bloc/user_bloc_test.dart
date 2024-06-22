import "dart:convert";

import "package:bloc_test/bloc_test.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/bloc/user_bloc.dart";
import "package:mascotas/datasource/user_datasource.dart";
import "package:mascotas/exception/datasource_exception.dart";
import "package:mascotas/model/user.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";

import "../datasource/mocks.dart";
import "../datasource/pets_datasource_test.mocks.dart";
import "user_bloc_test.mocks.dart";

@GenerateNiceMocks([MockSpec<FlutterSecureStorage>()])
void main() {
  late MockApi mockApi;
  late MockFlutterSecureStorage mockStorage;
  late UserDatasource usersDatasource;

  setUp(() {
    mockApi = MockApi();
    mockStorage = MockFlutterSecureStorage();
    usersDatasource = UserDatasource(api: mockApi, storage: mockStorage);
  });

  blocTest(
    "Inicia sesion de forma exitosa y obtengo los datalles del usuario",
    setUp: () {
      when(
        mockApi.post(
          any,
        ),
      ).thenAnswer((_) async => Response(jsonEncode({"token": "token"}), 200));
    },
    build: () => UserBloc(usersDatasource: usersDatasource),
    act: (cubit) => cubit.login(email: "ximena@example.com", password: "password"),
    expect: () => [
      Loaded(value: User.fromJson(jsonDecode(userJson))),
    ],
  );

  blocTest(
    "Al iniciar sesion, algo sale mal y obtengo un error",
    setUp: () {
      when(
        mockApi.post(
          any,
        ),
      ).thenAnswer((_) async => throw Exception("Algo salió mal"));
    },
    build: () => UserBloc(usersDatasource: usersDatasource),
    act: (cubit) => cubit.login(email: "ximena@example.com", password: "password"),
    errors: () => [isA<DatasourceException>()],
  );
}