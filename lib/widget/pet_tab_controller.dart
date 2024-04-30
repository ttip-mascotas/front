import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/model/pet.dart';
import 'package:mascotas/widget/medical_visit_tab_view.dart';
import 'package:mascotas/widget/pet_floating_action_button.dart';
import 'package:mascotas/widget/treatment_form.dart';
import 'package:mascotas/widget/treatment_tab_view.dart';

import 'analysis_tab_view.dart';
import 'medical_visit_registration_form.dart';

class PetTabController extends StatefulWidget {
  const PetTabController({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  State<PetTabController> createState() => _PetTabControllerState();
}

class _PetTabControllerState extends State<PetTabController> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        initialIndex: _index,
        child: Scaffold(
          appBar: TabBar(
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            tabs: const [
              Tab(
                text: "Visitas",
              ),
              Tab(
                text: "Analisis",
              ),
              Tab(
                text: "Tratamiento",
              ),
            ],
          ),
          body: TabBarView(
            children: [
              MedicalVisits(medicalVisits: widget.pet.medicalVisits),
              const AnalysisTabView(),
              const TreatmentTabView(),
            ],
          ),
          floatingActionButton: _floatingActionButton(),
        ),
      ),
    );
  }

  Widget _floatingActionButton() {
    switch (_index) {
      case 1:
        return PetFloatingActionButton(
          onPressed: uploadPDF,
          icon: Icons.save,
        );
      case 2:
        return PetFloatingActionButton(
          onPressed: () => openTreatmentModal(context),
          icon: Icons.medical_information_outlined,
        );
      default:
        return PetFloatingActionButton(
          onPressed: () => openMedicalVisitRegistrationModal(context),
          icon: Icons.add,
        );
    }
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

  void openTreatmentModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        builder: (BuildContext context) => const TreatmentForm());
  }

  void uploadPDF() {
    FilePicker.platform.pickFiles().then((result) async {
      if (result != null) {
        File file = File(result.files.single.path!);
        await context.read<PetCubit>().uploadAnalysis(file);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Se cargo el análisis exitosamente')),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('No se pudo cargar el análisis: ${error.message}')),
      );
    });
  }
}
