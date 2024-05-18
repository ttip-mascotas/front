import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/bloc/treatment_cubit.dart';
import 'package:mascotas/widget/pets_scaffold.dart';
import 'package:mascotas/widget/treatment_detail.dart';

class TreatmentScheduleScreen extends StatelessWidget {
  final int id;

  const TreatmentScheduleScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<TreatmentCubit>().getTreatment(id);

    return const PetsScaffold(
      title: "Tratamiento",
      body: TreatmentScheduleDetails(),
    );
  }
}

class TreatmentScheduleDetails extends StatelessWidget {
  const TreatmentScheduleDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreatmentCubit, BlocState>(
      builder: (BuildContext context, BlocState state) {
        switch (state) {
          case Error():
            return Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Flexible(child: Text(state.message)),
                ],
              ),
            );
          case Loaded():
            return TreatmentDetail(treatment: state.value);
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
