import "dart:async";
import "dart:io";

import "package:http_parser/http_parser.dart";
import "package:mascotas/model/group.dart";
import "package:mascotas/model/pet.dart";

import "../exception/datasource_exception.dart";
import "datasource.dart";

class GroupDatasource extends BaseDatasource {
  GroupDatasource({required super.api});

  Future<Group> getGroup(int id) async {
    final response = await api.get("/groups/$id");

    return super.manageResponse<Group>(
      response,
      parseJson: (json) => Group.fromJson(json),
      message: "Hubo un problema al obtener el grupo con el id $id",
    );
  }

  Future<Pet> addPet(Pet pet, int id) async {
    try {
      final body = pet.toJson();
      final response = await api.post("groups/$id/pets", body: body);

      return super.manageResponse<Pet>(
        response,
        parseJson: (json) => Pet.fromJson(json),
        message: "Hubo un problema al registrar la mascota",
      );
    } on TimeoutException {
      return throw DatasourceException(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    }
  }

  Future<String> uploadAvatar(File file) async {
    final response = await api.upload("/pets/avatars",
        file: file, field: "avatar", contentType: MediaType("image", "jpeg"));

    return super.manageResponse<String>(response,
        parseJson: (json) => json["url"],
        message: "Hubo un problema al guardar la foto de tu mascota");
  }
}
