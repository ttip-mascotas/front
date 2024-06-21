import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/datasource/group_datasource.dart";
import "package:mascotas/exception/datasource_exception.dart";
import "package:mascotas/model/group.dart";
import "package:mascotas/model/pet.dart";
import "package:mascotas/utils/format.dart";
import "package:mascotas/utils/try_catch_form_exception.dart";

class GroupCubit extends Cubit<BlocState> {
  final GroupDatasource groupDatasource;

  GroupCubit({required this.groupDatasource}) : super(Loading());

  void init(int id) {
    getGroup(id);
  }

  Future<void> getGroup(int id) async {
    try {
      final pets = await groupDatasource.getGroup(id);
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
        final Group group = currentState.value;

        String url = "";
        if (photo.isNotEmpty) {
          url = await groupDatasource.uploadAvatar(File(photo));
        }

        final pet = Pet(
          name: name,
          photo: url,
          weight: weight,
          birthdate: parseDateStringAsDateTime(birthdate),
          breed: breed,
          fur: fur,
          sex: sex,
          age: 0,
        );

        final petResponse = await groupDatasource.addPet(pet, group.id);
        group.pets.add(petResponse);
        emit(Loading());
        emit(Loaded(value: group));
      }
    });
  }
}
