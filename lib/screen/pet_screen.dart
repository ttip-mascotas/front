import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/widget/pet_detail.dart';

import '../widget/medical_visit_registration_form.dart';

class PetScreen extends StatelessWidget {
  const PetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final purple = Colors.purple.shade200;
    context.read<PetCubit>().getPet(Random().nextInt(5) + 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Historial Médico",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: purple,
      ),
      body: const PetDetails(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        onPressed: () => openMedicalVisitRegistrationModal(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void openMedicalVisitRegistrationModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        builder: (BuildContext context) =>
            const MedicalVisitRegistrationForm());
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
            return PetDetail(pet: state.pet);
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
