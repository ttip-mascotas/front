import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/datasource/pets_datasource.dart';
import 'package:mascotas/model/pet.dart';

class PetCubit extends Cubit<BlocState> {
  final PetsDatasource petsDatasource;

  PetCubit({required this.petsDatasource}) : super(Loading());

  void getPet(int id) async {
    try {
      final pet = await petsDatasource.getPet(id);
      emit(Loaded(pet: pet));
    } catch (error) {
      emit(Error(message: error.toString()));
    }
  }
}

class BlocState {}

class Error extends BlocState {
  final String message;

  Error({required this.message});
}

class Loading extends BlocState {}

class Loaded extends BlocState {
  final Pet pet;

  Loaded({required this.pet});
}
