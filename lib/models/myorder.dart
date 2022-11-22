import 'package:restaurant/models/product.dart';

class MyOrder {
  MyOrder(
      {required this.username,
      required this.products,
      required this.total,
      String? id});

  String? username;
  List<Product>? products;
  int? total;
  String? id;

  static String toProductListString(List<Product>? products) {
    String string = '';
    for (var product in products!) {
      string += '${product.title}: \$${product.price}, \n';
    }
    return string;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'products': toProductListString(products),
      'total': total,
    };
  }
}
