// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:products_management/data/models/models.dart';

class Review {
  int? id;
  int? product_id;
  User? user;
  String? content;
  Review({
    this.id,
    this.product_id,
    this.user,
    this.content,
  });

  Review copyWith({
    int? id,
    int? product_id,
    User? user,
    String? content,
  }) {
    return Review(
      id: id ?? this.id,
      product_id: product_id ?? this.product_id,
      user: user ?? this.user,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': product_id,
      'content': content,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id']?.toInt(),
      product_id: map['product_id']?.toInt(),
      user: map['user'] == null ? null : User.fromMap(map['user']),
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Review(id: $id, product_id: $product_id, user: ${user!.name}, content: $content)';
  }
}
