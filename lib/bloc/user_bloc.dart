import "package:flutter_bloc/flutter_bloc.dart";
import "package:mascotas/datasource/user_datasource.dart";
import "package:mascotas/utils/try_catch_form_exception.dart";
import "bloc_state.dart";

class UserBloc extends Cubit<BlocState> {
  final UserDatasource usersDatasource;

  UserBloc({required this.usersDatasource}) : super(Loading());

  Future<void> login({required String email, required String password}) async {
    await tryCatchFormException(() async {
      final user = await usersDatasource.login(email, password);
      emit(Loaded(value: user));
    });
  }
}