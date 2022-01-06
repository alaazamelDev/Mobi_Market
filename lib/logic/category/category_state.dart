part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoadingFaliure extends CategoryState {
  final String error;

  const CategoryLoadingFaliure(this.error);

  @override
  List<Object> get props => [error];
}

class CategoryLoaded extends CategoryState {
  final List<Category>? categories;
  const CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories!];
}
