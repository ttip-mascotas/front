import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/bloc/group_bloc.dart";
import "package:mascotas/model/group.dart";
import "package:mascotas/model/pet.dart";
import "package:mascotas/navigation/navigation.dart";
import "package:mascotas/utils/format.dart";
import "package:mascotas/widget/avatar.dart";
import "package:mascotas/widget/pet_registration_form.dart";
import "package:mascotas/widget/pets_divider.dart";
import "package:mascotas/widget/pets_scaffold.dart";
import "package:mascotas/widget/user_drawer.dart";

class PetsScreen extends StatelessWidget {
  final int id;

  const PetsScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    final purple = Colors.purple.shade200;
    context.read<GroupCubit>().getGroup(id);

    return PetsScaffold(
      title: "Mis Mascotas",
      drawer: const UserDrawer(),
      body: const PetsBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        onPressed: () => openPetRegistrationModal(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void openPetRegistrationModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        builder: (BuildContext context) => const PetRegistrationForm());
  }
}

class PetsBody extends StatelessWidget {
  const PetsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, BlocState>(
      builder: (BuildContext context, BlocState state) {
        switch (state) {
          case Error():
            return Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Flexible(child: Text(state.message)),
                ],
              ),
            );
          case Loaded():
            final Group value = state.value;
            return Pets(pets: value.pets);
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class Pets extends StatelessWidget {
  final List<Pet> pets;

  const Pets({
    super.key,
    required this.pets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final Pet pet = pets[index];
          return PetBasicInfo(pet: pet);
        },
        separatorBuilder: (BuildContext context, int index) =>
            const PetsDivider(),
        itemCount: pets.length,
      ),
    );
  }
}

class PetBasicInfo extends StatelessWidget {
  final Pet pet;

  const PetBasicInfo({
    super.key,
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigation.goToPetScreen(context: context, id: pet.id!),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Avatar.avatarSmallURL(url: pet.photo),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PetInfo(
                    info: pet.name,
                    icon: Icons.pets,
                  ),
                  PetInfo(
                    info: convertAgeToString(pet.age),
                    icon: Icons.access_time,
                  ),
                  PetInfo(
                    info: convertWeightToString(pet.weight),
                    icon: Icons.scale,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PetInfo extends StatelessWidget {
  final String info;
  final IconData icon;

  const PetInfo({
    super.key,
    required this.info,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.purple.shade200,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(info),
        ],
      ),
    );
  }
}
