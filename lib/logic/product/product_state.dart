// ignore_for_file: non_constant_identifier_names

part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

// this happen when there is a problem
// with sending the product to the server
class ProductInsertionFaliure extends ProductState {
  final String error;

  const ProductInsertionFaliure(this.error);

  @override
  List<Object> get props => [error];
}

/*
* This state occurs when Product is inserted sucessfully
* to the database in the server
*/
class ProductInsertionSucceeded extends ProductState {}

class ProductLoading extends ProductState {}

/*
 * this state occurs when list of product is fetched
 * successfully from the server.
 */
class ProductLoaded extends ProductState {
  final List<Product>? products;

  const ProductLoaded(this.products);
}

/*
 * When product is deleted successfully 
 */
class ProductDeletetionSucceeded extends ProductState {}

class ProductDeletetionFaliure extends ProductState {}

// this occure when some error happen while fetching
// products from server
class ProductLoadFailure extends ProductState {
  final String error;

  const ProductLoadFailure(this.error);
}
