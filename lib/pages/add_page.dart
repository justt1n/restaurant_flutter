import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restaurant/constants.dart';
import 'package:restaurant/models/product.dart';
import 'package:restaurant/pages/home_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddPage createState() => _AddPage();
}

class _AddPage extends State<AddPage> {
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
              createProduct(product);
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
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const HomePage(),
                      duration: const Duration(seconds: 1),
                      type: PageTransitionType.rightToLeft));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red.shade500),
            ),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future createProduct(Product product) async {
    final docUser = FirebaseFirestore.instance.collection('products').doc();
    product.id = docUser.id;
    final json = product.toJson();
    await docUser.set(json);
  }
}
