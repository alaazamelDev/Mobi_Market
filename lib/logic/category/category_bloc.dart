import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_management/data/models/category.dart';
import 'package:products_management/data/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<GetAllCategories>((event, emit) async {
      emit(CategoryLoading());
      List<Category> categories = [];
      try {
        categories =
            await categoryRepository.getCategoriesFromInternalStorage();
      } catch (ex) {
        emit(const CategoryLoadingFaliure('Error while loading categories'));
      }
      emit(CategoryLoaded(categories));
    });
  }
}
