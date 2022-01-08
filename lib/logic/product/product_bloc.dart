import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_management/data/models/models.dart';
import 'package:products_management/data/models/sort_type_enum.dart';
import 'package:products_management/data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductLoading()) {
    // fetch prodcuts from api
    on<GetAllProducts>((event, emit) async {
      emit(ProductLoading());
      List<Product>? products =
          await productRepository.getAllProucts(sortBy: event.sortType);
      if (products == null) {
        emit(const ProductLoadFailure('Error while fetching products'));
      } else {
        // When data is loaded, send them back to UI
        emit(ProductLoaded(products));
      }
    });

    // this event is called when we are ready to submit the product to the api
    on<ConfirmProductInsertion>((event, emit) async {
      emit(ProductLoading());
      bool isDone = await productRepository.addProduct(event.product);
      if (!isDone) {
        emit(const ProductInsertionFaliure('Error while inserting a product'));
      } else {
        emit(ProductInsertionSucceeded());
      }
    });

    // this event is called to delete a product from database
    on<DeleteProduct>((event, emit) async {
      emit(ProductLoading());
      bool isDone = await productRepository.deleteProudct(event.productID);
      if (!isDone) {
        emit(ProductDeletetionFaliure());
      } else {
        emit(ProductDeletetionSucceeded());
      }
    });

    // This event is called when new data is updated for the product
    on<UpdateProduct>((event, emit) async {
      emit(ProductLoading());
      bool isDone =
          await productRepository.updateProduct(product: event.product);
      if (!isDone) {
        emit(const ProductUpdateFaliure('Error while updating the product'));
      } else {
        emit(ProductUpdateSucceeded());
      }
    });

    on<IncreaseViews>((event, emit) async {
      bool isDone =
          await productRepository.increaseViews(productID: event.productID);
      if (!isDone) {
        emit(const ProductUpdateFaliure(
            'Error while increasing views of the product'));
      } else {
        emit(ProductUpdateSucceeded());
      }
    });

    on<LikeProduct>((event, emit) async {
      bool isDone =
          await productRepository.likeProduct(productID: event.productID);
      if (!isDone) {
        emit(const ProductUpdateFaliure(
            'Error while performing like operation on the product'));
      } else {
        emit(ProductLikeSucceeded());
      }
    });

    on<AddReview>((event, emit) async {
      bool isDone = await productRepository.addReview(
        productID: event.productID,
        content: event.content,
      );
      if (!isDone) {
        emit(const ProductReviewInsertionFailed(
            'Error while adding a review on the product'));
      } else {
        emit(ProductReviewInsertionSucceeded());
      }
    });

    on<SearchProduct>((event, emit) async {
      // fetch prodcuts from api
      emit(ProductLoading());
      List<Product>? products =
          await productRepository.search(query: event.query);
      if (products == null) {
        emit(const ProductLoadFailure('Error while fetching products'));
      } else {
        // When data is loaded, send them back to UI
        emit(ProductLoaded(products));
      }
    });
  }
}
