// ignore_for_file: non_constant_identifier_names

part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialized extends ProductState {
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
  final Product product;

  ProductInitialized({
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
  }) : product = Product(
          name: name,
          price: price,
          image_url: image_url,
          exp_date: exp_date,
          category_id: category_id,
          phone_number: phone_number,
          description: description,
          quantity: quantity,
          views: views,
          discount_list: discount_list,
        );

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

class ProductInsertionFaliure extends ProductState {
  final String error;

  const ProductInsertionFaliure(this.error);

  @override
  List<Object> get props => [error];
}

class ProductInsertionSucceeded extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product>? products;

  const ProductLoaded(this.products);
}

class ProductLoadFailure extends ProductState {
  final String error;

  const ProductLoadFailure(this.error);
}
