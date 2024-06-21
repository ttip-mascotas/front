import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:mascotas/datasource/user_datasource.dart";
import "package:mascotas/exception/datasource_exception.dart";

import "bloc_state.dart";

class GroupsBloc extends Cubit<BlocState> {
  final UserDatasource usersDatasource;

  GroupsBloc({required this.usersDatasource}) : super(Loading());

  Future<void> getGroups({
    required int userId,
  }) async {
    try {
      final groups = await usersDatasource.getGroups(userId);
      emit(Loaded(value: groups));
    } on DatasourceException catch (error) {
      emit(Error(message: error.message));
    } catch (error) {
      debugPrint(error.toString());
      emit(Error(message: "Ocurrió un error inesperado"));
    }
  }
}
