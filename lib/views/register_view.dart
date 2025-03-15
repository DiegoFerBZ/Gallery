import 'package:flutter/material.dart';
import 'package:gallery/components/Tittle_Subtitle.dart';
import '../components/register_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: SafeArea(
        child: SingleChildScrollView( // Permite desplazamiento
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Column(
            children: [
              const AuthTitle(
                mainTitle: 'Bienvenido a Store',
                subtitle: 'Regístrate para continuar',
              ),
              const SizedBox(height: 30),
              const RegisterForm(),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('¿Ya tienes cuenta? Inicia Sesión'),
              )
            ],
          ),
        ),
      ),
    );
  }
}