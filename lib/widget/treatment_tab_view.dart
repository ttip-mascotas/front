import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/model/treatment.dart';
import 'package:mascotas/utils/format.dart';
import 'package:mascotas/widget/pets_divider.dart';

class TreatmentTabView extends StatelessWidget {
  final List<Treatment> treatments;

  const TreatmentTabView({
    super.key,
    required this.treatments,
  });

  @override
  Widget build(BuildContext context) {
    return treatments.isNotEmpty
        ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                final treatment = treatments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Medicina: ${treatment.medicine}'),
                        Text('Dosis: ${treatment.dose}'),
                        Text('Inicio: ${formatDateToString(treatment.startDate)}')
                      ]),
                );
              },
              separatorBuilder: (context, index) => const PetsDivider(),
              itemCount: treatments.length),
        )
        : const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No hay tratamientos registrados'),
          );
  }
}
