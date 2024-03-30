import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/model/pet.dart';

class PetsDatasource {
  final Api api;

  PetsDatasource({required this.api});

  Future<Pet> getPet(int id) async {
    try {
      final response = await api.get("/pets/$id");

      return _manageResponse<Pet>(
        response,
        parseJson: (json) => Pet.fromJson(json),
        message: "Failed to load pet details",
      );
    } on TimeoutException {
      return Future.error(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    } catch (e) {
      return Future.error("Ha ocurrido un error inesperado.");
    }
  }

  Future<String> getPets() async {
    final response = await api.get("/pets");

    return _manageResponse<String>(
      response,
      parseJson: (json) => json,
      message: "Failed to load pets",
    );
  }

  T _manageResponse<T>(Response response,
      {required T Function(dynamic) parseJson, required String message}) {
    if (_isSuccessful(response)) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return parseJson(json);
    } else {
      throw Exception(message);
    }
  }

  bool _isSuccessful(Response response) =>
      response.statusCode >= 200 || response.statusCode < 300;
}
