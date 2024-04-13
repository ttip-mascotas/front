import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mascotas/exception/datasource_exception.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/utils/format.dart';

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
      emit(Error(message: "Ocurrió un error inesperado"));
    }
  }

  Future<void> addPet(
      {required String name,
      required String photo,
      required double weight,
      required String birthdate,
      required String breed,
      required String fur,
      required String sex}) async {
    try {
      final pet = Pet(
        name: name,
        photo: photo,
        weight: weight,
        birthdate: formatStringToDateTime(birthdate),
        breed: breed,
        fur: fur,
        sex: sex,
        id: 0,
        age: 0,
      );
      if (state is Loaded) {
        final Loaded currentState = state as Loaded;
        final pets = currentState.value as List<Pet>;

        emit(Loading());
        final petResponse = await petsDatasource.addPet(pet);
        pets.add(petResponse);
        emit(Loaded(value: pets));
      }
    } on DatasourceException catch (error) {
      emit(Error(message: error.message));
    } catch (error) {
      emit(Error(message: "Ocurrió un error inesperado"));
    }
  }
}
