import 'package:flutter/material.dart';
import 'package:gallery/components/Tittle_Subtitle.dart';
import '../components/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: SingleChildScrollView( // Permite desplazamiento
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Column(
            children: [
            const AuthTitle(
              mainTitle: 'Bienvenido a Store',
              subtitle: 'Inicia sesión para continuar',
            ),
            const LoginForm(),

            const SizedBox(height: 30),

            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: const Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    ));
  }
}
