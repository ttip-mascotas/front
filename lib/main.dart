import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/bloc/pets_bloc.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/screen/pets_screen.dart';
import 'package:mascotas/style/theme.dart';
import 'datasource/pets_datasource.dart';
import 'notifications/notifier.dart';

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

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) {
          return PetCubit(petsDatasource: petsDatasource, notifier: notifier);
        }),
        BlocProvider(
            create: (BuildContext context) =>
                PetsCubit(petsDatasource: petsDatasource)..init()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: "History Pets",
        theme: theme,
        home: const PetsScreen(),
      ),
    );
  }
}
