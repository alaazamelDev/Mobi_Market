// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Discount {
  double? discount_percentage;
  DateTime? date;
  int? product_id;
  int? numberOfDays;
  Discount({
    this.discount_percentage,
    this.date,
    this.product_id,
    this.numberOfDays,
  });

  Discount copyWith({
    double? discount_percentage,
    DateTime? date,
    int? product_id,
    int? numnerOfDays,
  }) {
    return Discount(
      discount_percentage: discount_percentage ?? this.discount_percentage,
      date: date ?? this.date,
      product_id: product_id ?? this.product_id,
      numberOfDays: numnerOfDays,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'discount_percentage': discount_percentage.toString(),
      'date': date!.toIso8601String(),
    };
  }

  factory Discount.fromMap(Map<String, dynamic> map) {
    return Discount(
      discount_percentage: map['discount_percentage']?.toDouble() ?? 0.0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      product_id: map['product_id']?.toInt(),
      numberOfDays: map['numnerOfDays']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Discount.fromJson(String source) =>
      Discount.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Discount(discount_percentage: $discount_percentage, date: $date, product_id: $product_id, numnerOfDays: $numberOfDays)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Discount &&
        other.discount_percentage == discount_percentage &&
        other.date == date &&
        other.product_id == product_id &&
        other.numberOfDays == numberOfDays;
  }

  @override
  int get hashCode {
    return discount_percentage.hashCode ^
        date.hashCode ^
        product_id.hashCode ^
        numberOfDays.hashCode;
  }
}
