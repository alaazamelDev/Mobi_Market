// ignore_for_file: non_constant_identifier_names

part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

// fill the fields
class InitializeProduct extends ProductEvent {
  final String? name;
  final double? price;
  final String? image_url;
  final String? exp_date;
  final int? category_id;
  final String? phone_number;
  final String? description;
  final int? quantity;
  final int? views;
  final List<Discount>? discount_list;

  const InitializeProduct({
    this.name,
    this.price,
    this.image_url,
    this.exp_date,
    this.category_id,
    this.phone_number,
    this.description,
    this.quantity,
    this.views,
    this.discount_list,
  });

  @override
  List<Object> get props => [
        name!,
        price!,
        image_url!,
        exp_date!,
        category_id!,
        phone_number!,
        description!,
        quantity!,
        views!,
        discount_list!,
      ];
}

// submit the data after validation, to be inserted
class ConfirmProductInsertion extends ProductEvent {
  final Product product;
  const ConfirmProductInsertion({required this.product});

  @override
  List<Object> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final int productID;

  const DeleteProduct(this.productID);
}

class UpdateProduct extends ProductEvent {
  final Product product;

  const UpdateProduct(this.product);
}

class GetAllProducts extends ProductEvent {
  const GetAllProducts();
}
