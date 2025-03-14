import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/image_service.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  File? _selectedImage;
  bool _isUploading = false;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isUploading = true);
      
      final productService = Provider.of<ProductService>(context, listen: false);
      String imageUrl = _urlController.text.trim();

      // Si hay imagen local, subirla
      if (_selectedImage != null) {
        final imageService = Provider.of<ImageService>(context, listen: false);
        imageUrl = await imageService.uploadImage(_selectedImage!);
      }

      final newProduct = Product(
        name: _nameController.text,
        description: _descController.text,
        imageUrl: imageUrl,
        price: double.parse(_priceController.text),
      );

      await productService.createProduct(newProduct);
      
      setState(() => _isUploading = false);
      Navigator.pop(context);
    }
  }

  Future<void> _pickImage() async {
    final imageService = Provider.of<ImageService>(context, listen: false);
    final image = await imageService.takePhoto();
    if (image != null) {
      setState(() => _selectedImage = image);
      _urlController.clear(); // Limpiar URL si se sube imagen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildImageSection(),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Ingrese nombre' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Ingrese descripción' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Ingrese precio' : null,
              ),
              const SizedBox(height: 15),
              _buildUrlInput(),
              const SizedBox(height: 25),
              _isUploading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('GUARDAR PRODUCTO'),
                    ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildImageSection() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey[200],
              backgroundImage: _selectedImage != null 
                  ? FileImage(_selectedImage!) 
                  : null,
              child: _selectedImage == null
                  ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                  : null,
            ),
            if (_selectedImage != null)
              Positioned(
                right: 10,
                bottom: 10,
                child: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedImage = null;
                      _urlController.clear();
                    });
                  },
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildUrlInput() {
    return TextFormField(
      controller: _urlController,
      decoration: InputDecoration(
        labelText: 'URL de Imagen',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: _pickImage,
        ),
        hintText: 'Ingrese URL o use la cámara',
      ),
      enabled: _selectedImage == null,
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() => _selectedImage = null);
        }
      },
    );
  }
}