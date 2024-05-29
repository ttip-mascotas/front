import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/datasource/treatment_datasource.dart';
import 'package:mascotas/model/treatment.dart';
import 'package:mascotas/model/treatment_log.dart';
import 'package:mascotas/utils/try_catch_form_exception.dart';

class TreatmentCubit extends Cubit<BlocState> {
  final TreatmentsDatasource treatmentsDatasource;

  TreatmentCubit({required this.treatmentsDatasource}) : super(Loading());

  Future<void> getTreatment(int id) async {
    tryCatchFormException(() async {
      final treatment = await treatmentsDatasource.getTreatment(id);
      emit(Loaded(value: treatment));
    });
  }

  void checkTreatmentLog(int treatmentLogId) async {
    tryCatchFormException(() async {
      if (state is Loaded) {
        final Loaded currentState = state as Loaded;
        final Treatment treatment = currentState.value;
        final TreatmentLog treatmentLog = treatment.logs
            .firstWhere((treatmentLog) => treatmentLog.id == treatmentLogId);
        treatmentLog.check();
        emit(Loading());
        //TODO: descomentar esta linea cuando este disponible el endpoint
        /*final treatmentResponse = await treatmentsDatasource.checkTreatmentLog(
        treatment.id!,
        treatmentLog,
      );*/
        emit(Loaded(value: treatment));
      }
    });
  }
}
