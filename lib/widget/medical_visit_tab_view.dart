import 'package:flutter/material.dart';
import 'package:mascotas/model/medical_visit.dart';
import 'package:mascotas/utils/format.dart';
import 'package:mascotas/widget/pets_divider.dart';

class MedicalVisits extends StatelessWidget {
  final List<MedicalVisit> medicalVisits;

  const MedicalVisits({
    super.key,
    required this.medicalVisits,
  });

  @override
  Widget build(BuildContext context) {
    return medicalVisits.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              final medicalVisit = medicalVisits[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MedicalVisitDetail(
                      text: medicalVisit.specialist,
                      icon: Icons.medical_services_rounded,
                    ),
                    MedicalVisitDetail(
                      text: medicalVisit.address,
                      icon: Icons.location_on,
                    ),
                    MedicalVisitDetail(
                      text: formatDateToString(medicalVisit.date),
                      icon: Icons.calendar_month_rounded,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        medicalVisit.observations,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const PetsDivider(),
            itemCount: medicalVisits.length)
        : const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No hay visitas médicas registradas."),
          );
  }
}

class MedicalVisitDetail extends StatelessWidget {
  final IconData icon;
  final String text;

  const MedicalVisitDetail({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon, color: Colors.purple.shade200),
          ),
          Text(text),
        ],
      ),
    );
  }
}
