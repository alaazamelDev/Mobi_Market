// ignore_for_file: non_constant_identifier_names

part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
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
