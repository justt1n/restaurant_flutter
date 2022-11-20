class Product {
  String? id;
  String image;
  String title;
  double price;
  bool isSelected;

  Product(
      {required this.image,
      required this.title,
      required this.price,
      required this.isSelected,
      String? id});

  Product copyWith({
    String? id,
    String? title,
    double? price,
    String? image,
    bool? isSelected,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'isSelected': isSelected,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        image: json['image'],
        isSelected: json['isSelected']);
  }
}
