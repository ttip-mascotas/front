import 'package:flutter/material.dart';
import 'package:mascotas/model/treatment.dart';
import 'package:mascotas/navigation/navigation.dart';
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
        ? ListView.separated(
            itemBuilder: (context, index) {
              final treatment = treatments[index];
              return TreatmentItem(treatment: treatment);
            },
            separatorBuilder: (context, index) => const PetsDivider(),
            itemCount: treatments.length)
        : const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No hay tratamientos registrados'),
          );
  }
}

class TreatmentItem extends StatelessWidget {
  final Treatment treatment;

  const TreatmentItem({super.key, required this.treatment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigation.goToTreatmentScheduleScreen(
          context: context, id: treatment.id!),
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TreatmentAttribute(
              text: treatment.medicine,
              icon: Icons.medication,
            ),
            TreatmentAttribute(
              text: treatment.dose,
              icon: Icons.numbers_rounded,
            ),
            TreatmentAttribute(
              text: formatDateToString(treatment.startDate),
              icon: Icons.schedule_rounded,
            ),
          ]),
        ),
      ),
    );
  }
}

class TreatmentAttribute extends StatelessWidget {
  final IconData icon;
  final String text;

  const TreatmentAttribute({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon, color: Colors.purple.shade200),
          ),
          Text(text),
        ],
      ),
    );
  }
}
