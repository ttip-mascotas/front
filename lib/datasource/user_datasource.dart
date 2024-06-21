import "dart:async";

import "package:mascotas/datasource/datasource.dart";
import "package:mascotas/exception/datasource_exception.dart";
import "package:mascotas/model/group.dart";

import "../model/user.dart";

class UserDatasource extends BaseDatasource {
  UserDatasource({required super.api});

  Future<User> login(String email, String password) async {
    return const User(id: 1, name: "Ximena", email: "ximena@example.com");
    /*try {
      final response = await api.get("/users");

      return super.manageResponse<User>(
        response,
        parseJson: (json) => User.fromJson(json),
        message: "Hubo un error al iniciar sesión",
      );
    } on TimeoutException {
      return throw DatasourceException(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    }*/
  }

  Future<List<Group>> getGroups(int id) async {
    try {
      final response = await api.get("/users/$id/groups");

      return super.manageResponse<List<Group>>(
        response,
        parseJson: (json) => json["results"]
            .map<Group>((groupJson) => Group.fromJson(groupJson))
            .toList(),
        message: "Hubo un error al obtener los grupos",
      );
    } on TimeoutException {
      return throw DatasourceException(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    }
  }
}
