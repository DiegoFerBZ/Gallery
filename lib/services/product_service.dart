import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery/models/product.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    return _firestore
        .collection('products')
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Product.fromFirestore(doc))
            .toList());
  }

  Future<Product> createProduct(Product product) async {
    final docRef = await _firestore.collection('products').add(product.toMap());
    return product.copyWith(id: docRef.id);
  }

}