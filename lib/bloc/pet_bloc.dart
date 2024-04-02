import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mascotas/exception/datasource_exception.dart';
import 'package:mascotas/model/medicalVisit.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/utils/format.dart';

class PetCubit extends Cubit<BlocState> {
  final PetsDatasource petsDatasource;

  PetCubit({required this.petsDatasource}) : super(Loading());

  Future<void> getPet(int id) async {
    try {
      final pet = await petsDatasource.getPet(id);
      emit(Loaded(pet: pet));
    } on DatasourceException catch (error) {
      emit(Error(message: error.message));
    } catch (error) {
      debugPrint(error.toString());
      emit(Error(message: "Ocurrio un error inesperado"));
    }
  }

  Future<void> addMedicalVisit(
      {required String specialist,
      required String address,
      required String date,
      required String observations}) async {
    try {
      final medicalVisit = MedicalVisit(
          specialist: specialist,
          address: address,
          date: formatStringToDateTime(date),
          observations: observations);
      if (state is Loaded) {
        final Loaded currentState = state as Loaded;
        final pet = currentState.pet;
        emit(Loading());
        final medicalVisitFromResponse = await petsDatasource.addMedicalVisit(medicalVisit, pet.id);
        pet.addMedicalVisit(medicalVisitFromResponse);
        emit(Loaded(pet: pet));
      }
    } on DatasourceException catch (error) {
      emit(Error(message: error.message));
    } catch (error) {
      debugPrint(error.toString());
      emit(Error(message: "Ocurrio un error inesperado"));
    }
  }
}

class BlocState extends Equatable {

  @override
  List<Object?> get props => [];
}

class Error extends BlocState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}

class Loading extends BlocState {
  @override
  List<Object?> get props => [];
}

class Loaded extends BlocState {
  final Pet pet;

  Loaded({required this.pet});

  @override
  List<Object?> get props => [pet];
}
