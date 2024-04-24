import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/utils/format.dart';
import 'package:mascotas/utils/validator.dart';
import 'package:mascotas/widget/input_title.dart';
import 'package:mascotas/widget/slider_with_number.dart';

class TreatmentForm extends StatefulWidget {
  const TreatmentForm({super.key});

  @override
  State<TreatmentForm> createState() => _TreatmentFormState();
}

class _TreatmentFormState extends State<TreatmentForm> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _numerOfTimesController = TextEditingController();
  double _frequency = 1;
  final _formKey = GlobalKey<FormState>();

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
                  title: "Medicamento",
                ),
                TextFormField(
                  controller: _medicineController,
                  validator: emptyFieldValidator,
                ),
                const InputTitle(
                  title: "Fecha de inicio",
                ),
                TextFormField(
                  controller: _dateController,
                  validator: emptyFieldValidator,
                  readOnly: true,
                  onTap: selectDate,
                ),
                const InputTitle(
                  title: "Dosis",
                ),
                TextFormField(
                  controller: _doseController,
                  validator: emptyFieldValidator,
                ),
                const InputTitle(
                  title: "Cantidad",
                ),
                TextFormField(
                  controller: _numerOfTimesController,
                  validator: emptyFieldValidator,
                  keyboardType: TextInputType.number,
                ),
                const InputTitle(
                  title: "Frecuencia",
                ),
                SliderWithNumber(
                  value: _frequency,
                  max: 24,
                  min: 1,
                  divisions: 24,
                  onChanged: (double value) {
                    setState(() {
                      _frequency = value;
                    });
                  }, text: '${_frequency.round()} hr',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                      onPressed: startTreatment,
                      child: const Text(
                        "Guardar",
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

  void startTreatment() {
    if (_formKey.currentState!.validate()) {
      try {
        context.read<PetCubit>().startTreatment(
          medicine: _medicineController.text,
          startDate: _dateController.text,
          dose: _doseController.text,
          numberOfTime: _numerOfTimesController.text,
          frequency: _frequency,
        );
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Se inició el tratamiento de forma exitosa")),
        );
      } catch (error) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    }
  }

  void selectDate() async {
    final now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(now.year + 1),
    );

    if (picked != null) {
      _dateController.text = formatDateToString(picked);
    }
  }

}
