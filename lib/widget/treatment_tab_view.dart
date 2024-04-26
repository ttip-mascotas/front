import 'package:flutter/material.dart';

class TreatmentTabView extends StatelessWidget {
  const TreatmentTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('No hay tratamientos registrados'),
    );
  }
}