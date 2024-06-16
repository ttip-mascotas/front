import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/bloc/pet_bloc.dart";
import "package:mascotas/model/pet.dart";
import "package:mascotas/navigation/navigation.dart";
import "package:mascotas/widget/avatar.dart";
import "package:mascotas/widget/pet_detail.dart";
import "package:mascotas/widget/pets_scaffold.dart";

class PetScreen extends StatelessWidget {
  final int id;

  const PetScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<PetCubit>().getPet(id);

    return const PetsScaffold(
      title: "Historial Médico",
      drawer: PetDrawer(),
      body: PetDetails(),
    );
  }
}

class PetDrawer extends StatelessWidget {
  const PetDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetCubit, BlocState>(builder: (context, state) {
      switch (state) {
        case Loaded():
          final Pet pet = state.value;
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Column(
                    children: [
                      Avatar.avatarSmallURL(url: pet.photo),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(pet.name,
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text("Buscar análisis"),
                  onTap: () => Navigation.goToSearchScreen(context: context),
                ),
              ],
            ),
          );
        default:
          return const SizedBox();
      }
    });
  }
}

class PetDetails extends StatelessWidget {
  const PetDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetCubit, BlocState>(
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
            return PetDetail(pet: state.value);
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
