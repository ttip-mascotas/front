import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:flutter_timezone/flutter_timezone.dart";
import "package:mascotas/bloc/groups_bloc.dart";
import "package:mascotas/bloc/pet_bloc.dart";
import "package:mascotas/bloc/user_bloc.dart";
import "package:mascotas/datasource/api.dart";
import "package:mascotas/datasource/group_datasource.dart";
import "package:mascotas/datasource/user_datasource.dart";
import "package:mascotas/screen/login_screen.dart";
import "package:mascotas/style/theme.dart";

import "bloc/group_bloc.dart";
import "datasource/pets_datasource.dart";
import "notifications/notifier.dart";

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  final notifier = Notifier(currentTimeZone);

  await notifier.requestNotificationsPermission();

  runApp(MainApp(notifier: notifier));
}

class MainApp extends StatelessWidget {
  final Notifier notifier;

  const MainApp({required this.notifier, super.key});

  @override
  Widget build(BuildContext context) {
    final api = Api();
    final petsDatasource = PetsDatasource(api: api);
    final usersDatasource = UserDatasource(
      api: api,
      storage: const FlutterSecureStorage(),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) {
          return PetCubit(petsDatasource: petsDatasource, notifier: notifier);
        }),
        BlocProvider(
            create: (BuildContext context) =>
                GroupCubit(groupDatasource: GroupDatasource(api: api))),
        BlocProvider(
            create: (BuildContext context) =>
                UserBloc(usersDatasource: usersDatasource)),
        BlocProvider(
            create: (BuildContext context) =>
                GroupsBloc(usersDatasource: usersDatasource)),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: "History Pets",
        theme: theme,
        home: const LoginScreen(),
      ),
    );
  }
}
