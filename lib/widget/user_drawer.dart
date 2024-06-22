import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/bloc/user_bloc.dart";
import "package:mascotas/model/user.dart";

class UserDrawer extends StatelessWidget {
  const UserDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, BlocState>(builder: (context, state) {
      switch (state) {
        case Loaded():
          final User user = state.value;
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 16,),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.purple.shade200, size: 16,),
                          const SizedBox(width: 16,),
                          Text(user.email, style: Theme.of(context).textTheme.bodySmall,),
                        ],
                      ),
                    ],
                  ),
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