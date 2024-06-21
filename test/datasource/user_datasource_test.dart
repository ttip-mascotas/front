import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mascotas/datasource/user_datasource.dart";
import "package:mascotas/model/group.dart";
import "package:mascotas/model/user.dart";
import "package:mockito/mockito.dart";

import "mocks.dart";
import "pets_datasource_test.mocks.dart";

void main() {

  late MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
  });

  test("Log in an user", () async {
    final UserDatasource userDatasource = UserDatasource(api: mockApi);

    when(mockApi.get("/users/login")).thenAnswer((_) async => Response(userJson, 200));

    final User user = await userDatasource.login("email", "password");

    expect(user.name, "Ximena");
    expect(user.email, "email");
    expect(user.id, 1);
  });

  test("get groups for an user", () async {
    final UserDatasource userDatasource = UserDatasource(api: mockApi);

    when(mockApi.get("/users/1/groups"))
        .thenAnswer((_) async => Response(groupListJson, 200));

    final List<Group> groupsResponse = await userDatasource.getGroups(1);

    expect(groupsResponse.length, 1);
    expect(groupsResponse[0].name, "Mi grupo");
  });
}