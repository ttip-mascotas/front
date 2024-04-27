import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/exception/datasource_exception.dart';
import 'package:mascotas/model/medical_visit.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/model/treatment.dart';

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
      return throw DatasourceException(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    }
  }

  Future<List<Pet>> getPets() async {
    final response = await api.get("/pets");

    return _manageResponse<List<Pet>>(
      response,
      parseJson: (json) =>
          json['results'].map<Pet>((json) => Pet.fromJson(json)).toList(),
      message: "Failed to load pets",
    );
  }

  Future<Pet> addPet(Pet pet) async {
    try {
      final body = pet.toJson();
      final response = await api.post("/pets", body: body);

      return _manageResponse<Pet>(
        response,
        parseJson: (json) => Pet.fromJson(json),
        message: "Hubo un problema al registrar la mascota",
      );
    } on TimeoutException {
      return throw DatasourceException(
          "Nuestros servidores están ocupados, intentalo nuevamente más tarde.");
    }
  }

  Future<MedicalVisit> addMedicalVisit(
      MedicalVisit medicalVisit, int id) async {
    final body = medicalVisit.toJson();
    final response = await api.post("/pets/$id/medical-records", body: body);

    return _manageResponse<MedicalVisit>(response,
        parseJson: (json) => MedicalVisit.fromJson(json),
        message: "Hubo un problema al registrar la visita médica");
  }

  Future<Treatment >startTreatment(Treatment treatment, int id) async {
    final body = treatment.toJson();
    final response = await api.post("/pets/$id/treatments", body: body);

    return _manageResponse<Treatment>(response,
        parseJson: (json) => Treatment.fromJson(json),
        message: "Hubo un problema al iniciar el tratamiento");
  }

  Future<String> uploadAnalysis(File file, int petId) async {
    final response = await api.upload("/pets/$petId/analyses", file: file, field: 'analysis');

    return _manageResponse<String>(response,
        parseJson: (json) => json["url"],
        message: "Hubo un problema al guardar el archivo");
  }

  Future<String> uploadAvatar(File file) async {
    final response = await api.upload("/pets/avatars", file: file, field: 'avatars');

    return _manageResponse<String>(response,
        parseJson: (json) => json["url"],
        message: "Hubo un problema al guardar la foto de tu mascota");
  }

  T _manageResponse<T>(Response response,
      {required T Function(dynamic) parseJson, required String message}) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    if (_isSuccessful(response)) {
      return parseJson(json);
    }
    if (_isClientError(response)) {
      throw DatasourceException(
        json['message'] ?? json['messages'].toString(),
      );
    } else {
      throw DatasourceException(message);
    }
  }

  bool _isSuccessful(Response response) =>
      response.statusCode >= 200 && response.statusCode < 300;

  bool _isClientError(Response response) =>
      response.statusCode >= 400 && response.statusCode < 500;
}
