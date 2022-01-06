// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:products_management/data/models/models.dart';

/// * This class represents a single product model ///
class Product {
  int? id;
  String? name;
  double? price;
  String? image_url;
  String? exp_date;
  int? category_id;
  String? phone_number;
  String? description;
  int? quantity;
  int? reviews_count;
  int? views;
  int? user_id;
  double? new_price;
  List<Review>? reviews;
  List<Discount>? discount_list;
  Product({
    this.id,
    this.name,
    this.price,
    this.image_url,
    this.exp_date,
    this.category_id,
    this.phone_number,
    this.description,
    this.quantity,
    this.reviews_count,
    this.views,
    this.user_id,
    this.new_price,
    this.reviews,
    this.discount_list,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image_url': image_url,
      'price': price!.toString(),
      'phone_number': phone_number,
      'exp_date': exp_date, // send date in ISO 8601 Format
      'description': description,
      'quantity': quantity.toString(),
      'category_id': category_id.toString(),
      'views': views.toString(),
      'discount_list': jsonEncode(
        discount_list!.map((discount) => discount.toMap()).toList(),
      ),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt(),
      name: map['name'],
      price: map['price']?.toDouble(),
      image_url: map['image_url'],
      exp_date: map['exp_date'],
      category_id: map['category_id']?.toInt(),
      phone_number: map['phone_number'],
      description: map['description'],
      quantity: map['quantity']?.toInt(),
      reviews_count: map['reviews_count']?.toInt(),
      views: map['views']?.toInt(),
      new_price: map['new_price']?.toDouble(),
      reviews: map['reviews']
              .map<Review>((review) => Review.fromMap(review))
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, imageUrl: $image_url, expiryDate: $exp_date, category_id: $category_id, phoneNumber: $phone_number, description: $description, quantity: $quantity, reviewsCount: $reviews_count, views: $views, newPrice: $new_price, reviews: $reviews )';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.image_url == image_url &&
        other.exp_date == exp_date &&
        other.category_id == category_id &&
        other.phone_number == phone_number &&
        other.description == description &&
        other.quantity == quantity &&
        other.reviews_count == reviews_count &&
        other.views == views &&
        other.new_price == new_price &&
        other.reviews == reviews;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        image_url.hashCode ^
        exp_date.hashCode ^
        category_id.hashCode ^
        phone_number.hashCode ^
        description.hashCode ^
        quantity.hashCode ^
        reviews_count.hashCode ^
        views.hashCode ^
        new_price.hashCode ^
        reviews.hashCode;
  }
}
