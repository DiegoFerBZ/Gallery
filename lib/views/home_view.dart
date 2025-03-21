import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery/components/products_grid.dart';
import 'package:gallery/models/product.dart';
import 'package:gallery/services/auth_service.dart';
import 'package:gallery/services/product_service.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {


  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
  final AuthService _authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<User?>(
          stream: _authService.authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final User? user = snapshot.data;
              return Text('Bienvenido ${user?.email ?? "Invitado"}');
            }
            return const Text('Cargando...');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Cerrar sesión
              await _authService.signOut();
              
              // Navegar a login y limpiar el stack de navegación
              Navigator.pushNamedAndRemoveUntil(
                context, 
                '/login', 
                (route) => false
              );
            },
            tooltip: 'Cerrar sesión',
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-product'),
        backgroundColor: Colors.deepOrange, // Color personalizado
        foregroundColor: Colors.white, // Color del ícono
        shape: RoundedRectangleBorder(
          // Forma personalizada
          borderRadius: BorderRadius.circular(16),
        ),
        heroTag: 'addProduct', // Identificador único si usas múltiples FABs
        child: const Icon(Icons.add), // Ícono alternativo
      ),
      body: StreamBuilder<List<Product>>(
        stream: Provider.of<ProductService>(context).getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Nuestros productos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child:
                    products.isEmpty
                        ? const Center(
                          child: Text('No hay productos disponibles'),
                        )
                        : GridProducts(products: products),
              ),
            ],
          );
        },
      ),
    );
  }
}
