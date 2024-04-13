import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/pets_bloc.dart';
import 'package:mascotas/utils/format.dart';
import 'package:mascotas/utils/validator.dart';
import 'package:mascotas/widget/input_title.dart';

class PetRegistrationForm extends StatefulWidget {
  const PetRegistrationForm({super.key});

  @override
  State<PetRegistrationForm> createState() => _PetRegistrationFormState();
}

class _PetRegistrationFormState extends State<PetRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _photoController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _weightController = TextEditingController();
  final _sexController = TextEditingController();
  final _breedController = TextEditingController();
  final _furController = TextEditingController();

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
                  title: "Nombre",
                ),
                TextFormField(
                  controller: _nameController,
                  validator: emptyFieldValidator,
                ),
                const InputTitle(
                  title: "Peso",
                ),
                TextFormField(
                  controller: _weightController,
                  validator: emptyFieldValidator,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                const InputTitle(
                  title: "Fecha de Nacimiento",
                ),
                TextFormField(
                  controller: _birthdateController,
                  validator: emptyFieldValidator,
                  readOnly: true,
                  onTap: selectDate,
                ),
                const InputTitle(
                  title: "Sexo",
                ),
                TextFormField(
                  controller: _sexController,
                  validator: emptyFieldValidator,
                ),
                const InputTitle(
                  title: "Raza",
                ),
                TextFormField(
                  controller: _breedController,
                  validator: emptyFieldValidator,
                ),
                const InputTitle(
                  title: "Pelaje",
                ),
                TextFormField(
                  controller: _furController,
                  validator: emptyFieldValidator,
                ),
                const InputTitle(
                  title: "Foto",
                ),
                TextFormField(
                  controller: _photoController,
                  validator: emptyFieldValidator,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                      onPressed: savePet,
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
      _birthdateController.text = formatDateToString(picked);
    }
  }

  void savePet() {
    if (_formKey.currentState!.validate()) {
      try {
        context.read<PetsCubit>().addPet(
              name: _nameController.text,
              photo: _photoController.text,
              weight: double.parse(_weightController.text),
              birthdate: _birthdateController.text,
              breed: _breedController.text,
              fur: _furController.text,
              sex: _sexController.text,
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
