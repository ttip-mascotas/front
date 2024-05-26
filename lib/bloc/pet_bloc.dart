import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mascotas/exception/datasource_exception.dart';
import 'package:mascotas/model/analysis.dart';
import 'package:mascotas/model/medical_visit.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/model/treatment.dart';
import 'package:mascotas/notifications/notifier.dart';
import 'package:mascotas/utils/format.dart';
import 'package:mascotas/utils/try_catch_form_exception.dart';

class PetCubit extends Cubit<BlocState> {
  final PetsDatasource petsDatasource;

  final Notifier notifier;

  PetCubit({required this.petsDatasource, required this.notifier})
      : super(Loading());

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
          date: parseDateStringAsDateTime(date),
          observations: observations);
      if (state is Loaded) {
        final Loaded currentState = state as Loaded;
        final Pet pet = currentState.value;
        final medicalVisitFromResponse =
            await petsDatasource.addMedicalVisit(medicalVisit, pet.id);
        pet.addMedicalVisit(medicalVisitFromResponse);
        emit(Loading());
        emit(Loaded(value: pet));
      }
    });
  }

  Future<void> startTreatment({
    required String medicine,
    required String dose,
    required String numberOfTime,
    required double frequency,
    required String time,
  }) async {
    await tryCatchFormException(() async {
      final treatment = Treatment(
        medicine: medicine,
        startDate: parseTimeOfDayStringAsDateTime(time),
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
        scheduledNotification(treatmentFromResponse);
        emit(Loading());
        emit(Loaded(value: pet));
      }
    });
  }

  void scheduledNotification(Treatment treatment) {
    DateTime dateTime = DateTime.now().add(const Duration(minutes: 2));
    for (var i = 1; i <= treatment.numberOfTime; i++) {
      notifier.scheduleTreatmentNotification(
          id: i,
          scheduledDate: dateTime,
          medicine: treatment.medicine,
          dose: treatment.dose);
      dateTime = dateTime.add(Duration(minutes: treatment.frequency));
    }
  }

  Future<void> uploadAnalysis(File file) async {
    await tryCatchFormException(() async {
      if (state is Loaded) {
        final Loaded currentState = state as Loaded;
        final Pet pet = currentState.value;
        final analysisFromResponse =
            await petsDatasource.uploadAnalysis(file, pet.id);
        pet.addAnalysis(analysisFromResponse);
        emit(Loading());
        emit(Loaded(value: pet));
      }
    });
  }

  Future<List<Analysis>> searchAnalysis(String text) async {
    if (state is Loaded) {
      final Loaded currentState = state as Loaded;
      final Pet pet = currentState.value;
      return await petsDatasource.searchAnalysis(text, pet.id);
    }
    return [];
  }
}
