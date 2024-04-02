import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/model/medicalVisit.dart';
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
        message: "Hubo un error al cargar la información de la mascota",
      );
    } on TimeoutException {
      return Future.error(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    } catch (e) {
      debugPrint(e.toString());
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

  Future<MedicalVisit> addMedicalVisit(MedicalVisit medicalVisit, int id) async {
    final body = medicalVisit.toJson();

    final response = await api.post("/pets/$id/medical-records", body: body);

    return _manageResponse<MedicalVisit>(
        response,
        parseJson: (json) => MedicalVisit.fromJson(json),
        message: "Hubo un problema al registrar la visita medica");
  }

  T _manageResponse<T>(Response response,
      {required T Function(dynamic) parseJson, required String message}) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    if (_isSuccessful(response)) {
      return parseJson(json);
    } if (_isClientError(response)){
      throw Exception(json['message']);
    } else {
      debugPrint(json['message']);
      throw Exception(message);
    }
  }

  bool _isSuccessful(Response response) =>
      response.statusCode >= 200 || response.statusCode < 300;

  bool _isClientError(Response response) =>
    response.statusCode >= 400 || response.statusCode < 500;
}
