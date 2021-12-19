import 'dart:convert';

import 'package:products_management/data/models/models.dart';

/// * This class represents a single product model ///
class Product {
  int id;
  String name;
  double price;
  String imageUrl;
  String expiryDate;
  Category category;
  String phoneNumber;
  int quantity;
  User owner;
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.expiryDate,
    required this.category,
    required this.phoneNumber,
    required this.quantity,
    required this.owner,
  });

  Product copyWith({
    int? id,
    String? name,
    double? price,
    String? imageUrl,
    String? expiryDate,
    Category? category,
    String? phoneNumber,
    int? quantity,
    User? owner,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      expiryDate: expiryDate ?? this.expiryDate,
      category: category ?? this.category,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      owner: owner ?? this.owner,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'expiryDate': expiryDate,
      'category': category.toMap(),
      'phoneNumber': phoneNumber,
      'quantity': quantity,
      'owner': owner.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      category: Category.fromMap(map['category']),
      phoneNumber: map['phoneNumber'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      owner: User.fromMap(map['owner']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, imageUrl: $imageUrl, expiryDate: $expiryDate, category: $category, phoneNumber: $phoneNumber, quantity: $quantity, owner: $owner)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.expiryDate == expiryDate &&
        other.category == category &&
        other.phoneNumber == phoneNumber &&
        other.quantity == quantity &&
        other.owner == owner;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        expiryDate.hashCode ^
        category.hashCode ^
        phoneNumber.hashCode ^
        quantity.hashCode ^
        owner.hashCode;
  }
}
