import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";
import "package:mascotas/bloc/group_bloc.dart";
import "package:mascotas/model/pet.dart";
import "package:mascotas/utils/format.dart";
import "package:mascotas/utils/validator.dart";
import "package:mascotas/widget/avatar_selector.dart";
import "package:mascotas/widget/form_structure.dart";
import "package:mascotas/widget/input_title.dart";
import "package:mascotas/widget/sex_input.dart";
import "package:mascotas/widget/slider_with_number.dart";
import "package:mascotas/widget/text_form_field_with_title.dart";

class PetRegistrationForm extends StatefulWidget {
  const PetRegistrationForm({super.key});

  @override
  State<PetRegistrationForm> createState() => _PetRegistrationFormState();
}

class _PetRegistrationFormState extends State<PetRegistrationForm> {
  final _nameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _breedController = TextEditingController();
  final _furController = TextEditingController();
  double _weight = 8;
  PetSex _sex = PetSex.female;
  String _photo = "";

  @override
  void dispose() {
    _nameController.dispose();
    _birthdateController.dispose();
    _breedController.dispose();
    _furController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormStructure(
      onSave: () => context.read<GroupCubit>().addPet(
            name: _nameController.text,
            photo: _photo,
            weight: _weight,
            birthdate: _birthdateController.text,
            breed: _breedController.text,
            fur: _furController.text,
            sex: _sex.name.toUpperCase(),
          ),
      successfulMessage: "Se registro la mascota de forma exitosa",
      errorMessage: (error) =>
          "No se pudo registrar la mascota: ${error.message}",
      buttonMessage: "Registrar",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AvatarSelector(
                photo: _photo,
                selectPhoto: selectPhoto,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormFieldWithTitle(
                  controller: _nameController,
                  title: "Nombre",
                  validator: emptyFieldValidator,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const InputTitle(
            title: "Peso",
          ),
          SliderWithNumber(
            value: _weight,
            max: 25,
            min: 0.1,
            divisions: 25,
            onChanged: (double value) {
              setState(() {
                _weight = value;
              });
            },
            text: "${_weight.round()} kg",
          ),
          TextFormFieldWithTitle(
            controller: _birthdateController,
            title: "Fecha de Nacimiento",
            validator: emptyFieldValidator,
            readOnly: true,
            onTap: selectDate,
          ),
          const InputTitle(
            title: "Sexo",
          ),
          SexInput(
            petSex: _sex,
            onSelect: selectSex,
          ),
          TextFormFieldWithTitle(
            controller: _breedController,
            title: "Raza",
            validator: emptyFieldValidator,
          ),
          TextFormFieldWithTitle(
            controller: _furController,
            title: "Pelaje",
            validator: emptyFieldValidator,
          ),
        ],
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

  void selectPhoto() async {
    final selectedPhoto =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (selectedPhoto == null) {
      return;
    }

    setState(() {
      _photo = selectedPhoto.path;
    });
  }

  selectSex(PetSex? value) {
    setState(() {
      _sex = value!;
    });
  }
}
