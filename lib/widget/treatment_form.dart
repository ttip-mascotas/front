import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
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
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _numberOfTimesController =
      TextEditingController();
  double _frequency = 1;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

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
                TextFormField(
                  controller: _doseController,
                  validator: emptyFieldValidator,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                      onPressed: startTreatment,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
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

  Future<void> startTreatment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      context
          .read<PetCubit>()
          .startTreatment(
            medicine: _medicineController.text,
            dose: _doseController.text,
            numberOfTime: _numberOfTimesController.text,
            frequency: _frequency,
            time: _timeController.text,
          )
          .then((_) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Se inició el tratamiento de forma exitosa")),
        );
      }).catchError((error) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('No se pudo iniciar el tratamiento: ${error.message}')),
        );
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
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
