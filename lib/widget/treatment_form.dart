import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/utils/validator.dart';
import 'package:mascotas/widget/form_structure.dart';
import 'package:mascotas/widget/input_title.dart';
import 'package:mascotas/widget/slider_with_number.dart';

class TreatmentForm extends StatefulWidget {
  const TreatmentForm({super.key});

  @override
  State<TreatmentForm> createState() => _TreatmentFormState();
}

class _TreatmentFormState extends State<TreatmentForm> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _numberOfTimesController =
      TextEditingController();
  double _frequency = 1;

  @override
  Widget build(BuildContext context) {
    return FormStructure(
      onSave: startTreatment,
      successfulMessage: "Se inició el tratamiento de forma exitosa",
      errorMessage: (error) =>
          'No se pudo iniciar el tratamiento: ${error.message}',
      buttonMessage: "Guardar",
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
            title: "Hora de inicio",
          ),
          TextFormField(
            controller: _timeController,
            validator: emptyFieldValidator,
            readOnly: true,
            onTap: selectTime,
          ),
          const InputTitle(
            title: "Dosis",
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _doseController,
                  validator: numberGreaterThanZero,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16,),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  'Gramos',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const InputTitle(
            title: "Cantidad",
          ),
          TextFormField(
            controller: _numberOfTimesController,
            validator: numberGreaterThanZero,
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
            },
            text: '${_frequency.round()} hr',
          ),
        ],
      ),
    );
  }

  Future<void> startTreatment() async {
    await context.read<PetCubit>().startTreatment(
          medicine: _medicineController.text,
          dose: _doseController.text,
          numberOfTime: _numberOfTimesController.text,
          frequency: _frequency,
          time: _timeController.text,
        );
  }

  void selectTime() {
    showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    ).then((selectedTime) {
      if (selectedTime != null) {
        _timeController.text = selectedTime.format(context);
      }
    });
  }
}
