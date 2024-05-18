import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mascotas/exception/datasource_exception.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/utils/format.dart';
import 'package:mascotas/utils/try_catch_form_exception.dart';

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
    await tryCatchFormException(() async {
      if (state is Loaded) {
        final Loaded currentState = state as Loaded;
        final List<Pet> pets = currentState.value;

        String url = "";
        if (photo.isNotEmpty) {
          url = await petsDatasource.uploadAvatar(File(photo));
        }

        final pet = Pet(
          name: name,
          photo: url,
          weight: weight,
          birthdate: formatDateStringToDateTime(birthdate),
          breed: breed,
          fur: fur,
          sex: sex,
          id: 0,
          age: 0,
        );

        final petResponse = await petsDatasource.addPet(pet);
        pets.add(petResponse);
        emit(Loaded(value: pets));
      }
    });
  }
}
