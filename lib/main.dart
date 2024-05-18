import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/bloc/pets_bloc.dart';
import 'package:mascotas/bloc/treatment.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/datasource/treatment.dart';
import 'package:mascotas/screen/pets_screen.dart';
import 'package:mascotas/style/theme.dart';

import 'datasource/pets_datasource.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final api = Api();
    final petsDatasource = PetsDatasource(api: api);
    final treatmentsDatasource = TreatmentsDatasource(api: api);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) {
          return PetCubit(petsDatasource: petsDatasource);
        }),
        BlocProvider(
            create: (BuildContext context) =>
                PetsCubit(petsDatasource: petsDatasource)..init()),
        BlocProvider(create: (BuildContext context) {
          return TreatmentCubit(treatmentsDatasource: treatmentsDatasource);
        }),
      ],
      child: MaterialApp(
        title: "History Pets",
        theme: theme,
        home: const PetsScreen(),
      ),
    );
  }
}
