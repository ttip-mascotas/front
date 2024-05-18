import 'package:flutter/material.dart';
import 'package:mascotas/model/treatment.dart';

class TreatmentDetail extends StatelessWidget {
  const TreatmentDetail({super.key, required this.treatment});

  final Treatment treatment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.purple.shade50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(child: Text(treatment.medicine)),
            ],
          ),
        ),
      ],
    );
  }
}
