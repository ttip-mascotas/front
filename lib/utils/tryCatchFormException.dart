import 'package:flutter/material.dart';
import 'package:mascotas/exception/datasource_exception.dart';

Future<void> tryCatchFormException(Future<void> Function() changeState) async {
  try {
    await changeState();
  } on DatasourceException catch (_) {
    rethrow;
  } catch (error) {
    debugPrint(error.toString());
    throw DatasourceException("Ocurrió un error inesperado");
  }
}