import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/pets_bloc.dart';
import 'package:mascotas/model/pet.dart';
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
  final _breedController = TextEditingController();
  final _furController = TextEditingController();
  double _weight = 8;
  PetSex _sex = PetSex.female;

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
                Slider(
                  value: _weight,
                  max: 25,
                  divisions: 25,
                  label: _weight.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _weight = value;
                    });
                  },
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
                Column(
                  children: [
                    ListTile(
                      title: const Text('Hembra'),
                      leading: Radio<PetSex>(
                        value: PetSex.female,
                        groupValue: _sex,
                        onChanged: (PetSex? value) {
                          setState(() {
                            _sex = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Macho'),
                      leading: Radio<PetSex>(
                        value: PetSex.male,
                        groupValue: _sex,
                        onChanged: (PetSex? value) {
                          setState(() {
                            _sex = value!;
                          });
                        },
                      ),
                    ),
                  ],
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
              weight: _weight,
              birthdate: _birthdateController.text,
              breed: _breedController.text,
              fur: _furController.text,
              sex: _sex.name.toUpperCase(),
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
