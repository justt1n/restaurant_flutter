import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/models/product.dart';

final style = GoogleFonts.roboto(
  fontSize: 30,
  color: Colors.white,
);

// final firebaseService = FirebaseService();

// final List burgeritems = [];
// get_data() async {
//   final Future<List> fsBurgeritems = firebaseService.getProduct('burgers');
//   burgeritems.add(fsBurgeritems);
// }
final List<Product> burgeritems = [
  Product(
      image: 'assets/humburgerone.jpg',
      title: 'Humburger Bo',
      price: 12.00,
      isSelected: false),
  Product(
      image: 'assets/humburgertwo.jpg',
      title: 'Humburger Hai San',
      price: 10.00,
      isSelected: false),
  Product(
      image: 'assets/humburgerthree.jpg',
      title: 'Humburger Thap Cam',
      price: 15.00,
      isSelected: false),
];

final List<Product> pizzaitems = [
  Product(
      image: 'assets/pizzaone.jpg',
      title: 'Pizza Xuc Xich',
      price: 24.00,
      isSelected: false),
  Product(
      image: 'assets/pizzatwo.jpg',
      title: 'Pizza Thap Cam',
      price: 30.00,
      isSelected: false),
  Product(
      image: 'assets/pizzathree.jpg',
      title: 'Pizza Dac Biet',
      price: 40.00,
      isSelected: false),
];

final List<Product> drinksitems = [
  Product(
    image: 'assets/coffee.jpg',
    title: 'Coffee',
    price: 08.00,
    isSelected: false,
  ),
  Product(
    image: 'assets/milk.jpg',
    title: 'Milk',
    price: 11.00,
    isSelected: false,
  ),
];
final List<Product> mealsitems = [
  Product(
      image: 'assets/puncake.jpg',
      title: 'Puncake',
      price: 30.00,
      isSelected: false),
  Product(
      image: 'assets/dessert.jpg',
      title: 'Dessert VIP',
      price: 35.00,
      isSelected: false),
  Product(
      image: 'assets/dessert2.jpg',
      title: 'Dessert Special',
      price: 45.00,
      isSelected: false),
];
