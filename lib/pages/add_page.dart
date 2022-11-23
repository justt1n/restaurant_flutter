import 'package:flutter/material.dart';
import 'package:restaurant/models/product.dart';
import 'package:restaurant/services/firebase_service.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddPage createState() => _AddPage();
}

class _AddPage extends State<AddPage> {
  final firebaseService = FirebaseService();
  final controllerTitle = TextEditingController();
  final controllerPrice = TextEditingController();
  final controllerImage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding Item'),
        backgroundColor: Colors.yellow.shade900,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerTitle,
            decoration: const InputDecoration(
              hintText: 'Title',
              hintTextDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllerPrice,
            decoration: const InputDecoration(
              hintText: 'Price',
              hintTextDirection: TextDirection.rtl,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllerImage,
            decoration: const InputDecoration(
              hintText: 'Image',
              hintTextDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              final product = Product(
                title: controllerTitle.text,
                price: double.parse(controllerPrice.text),
                image: controllerImage.text,
                isSelected: false,
              );
              firebaseService.createProduct(product, 'products');
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.yellow.shade900),
            ),
            child: const Text('Create'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red.shade500),
            ),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Future createProduct(Product product) async {
  //   final docUser = FirebaseFirestore.instance.collection('products').doc();
  //   product.id = docUser.id;
  //   final json = product.toJson();
  //   await docUser.set(json);
  // }
}
