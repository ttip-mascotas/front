import "dart:async";

import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:mascotas/datasource/datasource.dart";
import "package:mascotas/exception/datasource_exception.dart";
import "package:mascotas/model/group.dart";
import "package:mascotas/utils/storage_key.dart";

import "../model/user.dart";

class UserDatasource extends BaseDatasource {
  final FlutterSecureStorage storage;

  UserDatasource({required this.storage ,required super.api});

  Future<User> login(String email, String password) async {
    try {
      final response = await api.post("/login");

      final token = super.manageResponse<String>(
        response,
        parseJson: (json) => json["token"],
        message: "Hubo un error al iniciar sesión",
      );

      await storage.write(key: StorageKey.tokenStorageKey, value: token);
      // TODO: obtener usuario real
      return const User(id: 1, name: "Ximena", email: "ximena@example.com");
    } on TimeoutException {
      throw DatasourceException(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    }
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
