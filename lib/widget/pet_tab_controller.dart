import 'package:flutter/material.dart';
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
          onPressed: () => {},
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
}
