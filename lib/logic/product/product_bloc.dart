import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_management/data/models/models.dart';
import 'package:products_management/data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductInitialized()) {
    // fetch prodcuts from api
    on<GetAllProducts>((event, emit) async {
      emit(ProductLoading());
      List<Product>? products = await productRepository.getAllProucts();
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
  }
}
