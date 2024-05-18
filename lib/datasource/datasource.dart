import 'dart:convert';

import 'package:http/http.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/exception/datasource_exception.dart';

class BaseDatasource {
  final Api api;

  BaseDatasource({required this.api});

  T manageResponse<T>(Response response,
      {required T Function(dynamic) parseJson, required String message}) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    if (_isSuccessful(response)) {
      return parseJson(json);
    }
    if (_isClientError(response)) {
      throw DatasourceException(
        json['message'] ?? json['messages'].first,
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
