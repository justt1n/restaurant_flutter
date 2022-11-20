import 'package:flutter/material.dart';
import 'package:restaurant/models/product.dart';

class CheckOutManager with ChangeNotifier {
  List<Product> selectedList = [];

  getSelectedList() => selectedList;

  setSelectedList(List<Product> list) => selectedList = list;
}
