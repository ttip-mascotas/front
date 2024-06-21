import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/bloc/groups_bloc.dart";
import "package:mascotas/bloc/user_bloc.dart";
import "package:mascotas/model/group.dart";
import "package:mascotas/model/user.dart";
import "package:mascotas/navigation/navigation.dart";
import "package:mascotas/widget/pets_divider.dart";
import "package:mascotas/widget/pets_scaffold.dart";

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, BlocState>(builder: (context, state) {
      switch (state) {
        case Loaded():
          final User user = state.value;
          context.read<GroupsBloc>().getGroups(userId: user.id);
          return const PetsScaffold(
            body: GroupBody(),
            title: "Mis Grupos",
          );
        case Error():
          return Center(child: Text(state.message));
        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    });
  }
}

class GroupBody extends StatelessWidget {
  const GroupBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsBloc, BlocState>(builder: (context, state) {
      switch (state) {
        case Loaded():
          final List<Group> groups = state.value;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemBuilder: (context, index) => GroupItem(group: groups[index]),
              separatorBuilder: (context, index) => const PetsDivider(),
              itemCount: groups.length,
            ),
          );
        case Error():
          return Center(child: Text(state.message));
        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    });
  }
}

class GroupItem extends StatelessWidget {
  final Group group;

  const GroupItem({required this.group, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: GestureDetector(
        onTap: () => Navigation.goToPetsScreen(context: context, id: group.id),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.group,
                color: Colors.purple.shade200,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                group.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
