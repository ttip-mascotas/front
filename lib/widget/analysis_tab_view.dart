import 'package:flutter/material.dart';

class AnalysisTabView extends StatelessWidget {
  const AnalysisTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('No hay analisis registrados'),
    );
  }
}