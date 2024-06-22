import "dart:async";

import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:mascotas/datasource/datasource.dart";
import "package:mascotas/exception/datasource_exception.dart";
import "package:mascotas/model/group.dart";
import "package:mascotas/utils/storage_key.dart";

import "../model/user.dart";

class UserDatasource extends BaseDatasource {
  final storage = const FlutterSecureStorage();

  UserDatasource({required super.api});

  Future<User> login(String email, String password) async {
    //TODO: descomentar cuando este listo el endpoint de iniciar sesion
    return const User(id: 1, name: "Ximena", email: "ximena@example.com");
    /*try {
      final response = await api.get("/users/login");

      //await storage.write(key: StorageKey.tokenStorageKey, value: "");

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
