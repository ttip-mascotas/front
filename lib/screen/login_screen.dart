import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:mascotas/bloc/user_bloc.dart";
import "package:mascotas/navigation/navigation.dart";
import "package:mascotas/utils/validator.dart";
import "package:mascotas/widget/form_structure.dart";
import "package:mascotas/widget/pets_scaffold.dart";
import "package:mascotas/widget/text_form_field_with_title.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PetsScaffold(
      backgroundColor: Colors.purple.shade50,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Image(image: AssetImage("assets/icono.png")),
            ),
            FormStructure(
              onSave: () async {
                context.read<UserBloc>().login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              },
              successfulMessage: "Has iniciado sesión correctamente",
              errorMessage: (error) => "Ocurrio un problema al iniciar sesion",
              buttonMessage: "Iniciar sesión",
              navigate: () => Navigation.goToGroupScreen(context: context),
              child: Column(
                children: [
                  TextFormFieldWithTitle(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    title: "Email",
                    validator: emptyFieldValidator,
                  ),
                  TextFormFieldWithTitle(
                    controller: passwordController,
                    title: "Contraseña",
                    validator: emptyFieldValidator,
                    suffixIcon: Icons.remove_red_eye,
                    obscureText: isVisible,
                    onTapSuffixIcon: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      title: "Inicio de Sesión",
    );
  }
}
