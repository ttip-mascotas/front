import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mascotas/exception/datasource_exception.dart';

class PetsCubit extends Cubit<BlocState> {
  final PetsDatasource petsDatasource;

  PetsCubit({required this.petsDatasource}) : super(Loading());

  void init() {
    getPets();
  }

  Future<void> getPets() async {
    try {
      final pets = await petsDatasource.getPets();
      emit(Loaded(value: pets));
    } on DatasourceException catch (error) {
      emit(Error(message: error.message));
    } catch (error) {
      debugPrint(error.toString());
      emit(Error(message: "Ocurrio un error inesperado"));
    }
  }
}