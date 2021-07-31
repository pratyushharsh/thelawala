part of 'category_bloc.dart';

enum CategoryStatus {  INITIAL, LOADING, SUCCESS, FAILURE }

class CategoryState {
  final List<CategoryResponse> categories;
  final CategoryStatus status;

  CategoryState({ required this.categories, required this.status });

  CategoryState copyWith({List<CategoryResponse>? categories, CategoryStatus? status}) {
    return CategoryState(
      categories: categories ?? this.categories,
      status: status ?? this.status
    );
  }
}