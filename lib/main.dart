import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/style/theme.dart';

import 'datasource/pets_datasource.dart';
import 'screen/pet_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          PetCubit(petsDatasource: PetsDatasource(api: Api())),
      child: MaterialApp(
        title: "History Pets",
        theme: theme,
        home: const PetScreen(),
      ),
    );
  }
}
