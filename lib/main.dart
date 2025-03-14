import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery/components/product_add_view.dart';
import 'package:gallery/services/image_service.dart';
import 'package:gallery/services/product_service.dart';
import 'package:gallery/views/home_view.dart';
import 'package:gallery/views/register_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'views/login_view.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Necesario si usas Flutter 3+
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<ProductService>(create: (_) => ProductService()),
        Provider<ImageService>(create: (_) => ImageService()), 
      ],
      child: MaterialApp(
        title: 'Tienda Virtual',
        initialRoute: '/login',
        // En el MaterialApp:
routes: {
  '/login': (context) => const LoginView(),
  '/register': (context) => const RegisterView(),
  '/home': (context) => const HomeView(),
  '/add-product': (context) => const AddProductView(),
},
      ),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  final CameraDescription camera;

  GalleryScreen({required this.camera});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<File> images = [];

  Future<void> takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galería de Fotos'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.file(images[index], fit: BoxFit.cover);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: takePhoto,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}