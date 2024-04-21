import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/bloc_state.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/widget/pet_detail.dart';
import 'package:mascotas/widget/pets_scaffold.dart';

class PetScreen extends StatelessWidget {
  final int id;

  const PetScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<PetCubit>().getPet(id);

    return const PetsScaffold(
      title: "Historial Médico",
      body: PetDetails(),
    );
  }
}

class PetDetails extends StatelessWidget {
  const PetDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetCubit, BlocState>(
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
            return PetDetail(pet: state.value);
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
