import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mascotas/exception/datasource_exception.dart';
import 'package:mascotas/model/medical_visit.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/model/treatment.dart';
import 'package:mascotas/utils/format.dart';
import 'package:mascotas/utils/tryCatchFormException.dart';

class PetCubit extends Cubit<BlocState> {
  final PetsDatasource petsDatasource;

  PetCubit({required this.petsDatasource}) : super(Loading());

  Future<void> getPet(int id) async {
    try {
      final pet = await petsDatasource.getPet(id);
      emit(Loaded(value: pet));
    } on DatasourceException catch (error) {
      emit(Error(message: error.message));
    } catch (error) {
      debugPrint(error.toString());
      emit(Error(message: "Ocurrió un error inesperado"));
    }
  }

  Future<void> addMedicalVisit(
      {required String specialist,
      required String address,
      required String date,
      required String observations}) async {
    await tryCatchFormException(() async {
      final medicalVisit = MedicalVisit(
          specialist: specialist,
          address: address,
          date: formatStringToDateTime(date),
          observations: observations);
      if (state is Loaded) {
        final Loaded currentState = state as Loaded;
        final Pet pet = currentState.value;
        final medicalVisitFromResponse =
            await petsDatasource.addMedicalVisit(medicalVisit, pet.id);
        pet.addMedicalVisit(medicalVisitFromResponse);
        emit(Loaded(value: pet));
      }
    });
  }

  Future<void> startTreatment(
      {required String medicine,
      required String startDate,
      required String dose,
      required String numberOfTime,
      required double frequency}) async {
    await tryCatchFormException(() async {
      final treatment = Treatment(
        medicine: medicine,
        startDate: formatStringToDateTime(startDate),
        dose: dose,
        numberOfTime: int.parse(numberOfTime),
        frequency: frequency.round(),
      );
      if (state is Loaded) {
        final Loaded currentState = state as Loaded;
        final Pet pet = currentState.value;
        final treatmentFromResponse =
            await petsDatasource.startTreatment(treatment, pet.id);
        pet.startTreatment(treatmentFromResponse);
        emit(Loaded(value: pet));
      }
    });
  }

  Future<void> uploadAnalysis(File file) async {
    await tryCatchFormException(() async {
      if (state is Loaded) {
        final Loaded currentState = state as Loaded;
        final Pet pet = currentState.value;
        await petsDatasource.uploadAnalysis(file, pet.id);
        emit(Loaded(value: pet));
      }
    });
  }
}
