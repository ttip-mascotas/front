import 'package:flutter/material.dart';
import 'package:mascotas/model/treatment.dart';
import 'package:mascotas/widget/treatment_logs_table.dart';

class TreatmentDetail extends StatelessWidget {
  final Treatment treatment;

  const TreatmentDetail({super.key, required this.treatment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.purple.shade50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TreatmentAttributes(treatment: treatment),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: TreatmentLogsTable(treatmentLogs: treatment.logs),
          ),
        ),
      ],
    );
  }
}

class TreatmentAttributes extends StatelessWidget {
  final Treatment treatment;

  const TreatmentAttributes({super.key, required this.treatment});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Medicamento: ${treatment.medicine}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          Text(
            "Dosis: ${treatment.dose} miligramos",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
