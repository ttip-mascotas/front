import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/utils/format.dart';
import 'package:mascotas/utils/validator.dart';
import 'package:mascotas/widget/input_title.dart';

class MedicalVisitRegistrationForm extends StatefulWidget {
  const MedicalVisitRegistrationForm({super.key});

  @override
  State<MedicalVisitRegistrationForm> createState() =>
      _MedicalVisitRegistrationFormState();
}

class _MedicalVisitRegistrationFormState
    extends State<MedicalVisitRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _specialistController = TextEditingController();
  final _addressController = TextEditingController();
  final _observationsController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const InputTitle(
                  title: "Especialista",
                ),
                TextFormField(
                  controller: _specialistController,
                  validator: emptyFieldValidator,
                ),
                const InputTitle(
                  title: "Dirección",
                ),
                TextFormField(
                  controller: _addressController,
                  validator: emptyFieldValidator,
                ),
                const InputTitle(
                  title: "Fecha",
                ),
                TextFormField(
                  controller: _dateController,
                  validator: emptyFieldValidator,
                  readOnly: true,
                  onTap: selectDate,
                ),
                const InputTitle(
                  title: "Observaciones",
                ),
                TextFormField(
                  controller: _observationsController,
                  maxLines: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                      onPressed: saveMedicalVisit,
                      child: const Text(
                        "Registrar",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectDate() async {
    final now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 20),
      lastDate: now,
    );

    if (picked != null) {
      _dateController.text = formatDateToString(picked);
    }
  }

  void saveMedicalVisit() {
    if (_formKey.currentState!.validate()) {
      try {
        context.read<PetCubit>().addMedicalVisit(
              specialist: _specialistController.text,
              address: _addressController.text,
              date: _dateController.text,
              observations: _observationsController.text,
            );
        Navigator.pop(context);
      } catch (error) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    }
  }
}
