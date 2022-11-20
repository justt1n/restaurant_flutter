import 'package:restaurant/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  Future createProduct(Product product, String collectionPath) async {
    final docUser = FirebaseFirestore.instance.collection(collectionPath).doc();
    product.id = docUser.id;
    final json = product.toJson();
    await docUser.set(json);
  }

  Future<List> getProduct(String collectionPath) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collectionPath).get();
    final products = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(products);
    return products;
  }
}
