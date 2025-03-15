import 'package:flutter/material.dart';
import 'package:gallery/components/Tittle_Subtitle.dart';
import '../components/register_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          children: [
            const AuthTitle(
              mainTitle: 'Bienvenido a Store',
              subtitle: 'Registrate para continuar',
            ),
            const RegisterForm(),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('¿Ya tienes cuenta? Inicia Sesión'),
            )
          ],
        ),
      ),
    );
  }
}