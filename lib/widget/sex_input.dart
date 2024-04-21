import 'package:flutter/material.dart';
import 'package:mascotas/model/pet.dart';

class SexInput extends StatelessWidget {
  final PetSex petSex;

  final void Function(PetSex?) onSelect;

  const SexInput({required this.petSex, required this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<PetSex>(
          value: PetSex.female,
          groupValue: petSex,
          onChanged: onSelect,
        ),
        Expanded(
          child: Text(typeOfSex[PetSex.female.name.toUpperCase()]!),
        ),
        Radio<PetSex>(
          value: PetSex.male,
          groupValue: petSex,
          onChanged: onSelect,
        ),
        Expanded(
          child: Text(typeOfSex[PetSex.male.name.toUpperCase()]!),
        ),
      ],
    );
  }
}