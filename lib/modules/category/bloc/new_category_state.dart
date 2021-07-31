part of 'new_category_bloc.dart';

enum NewCategoryStatus { INITIAL, LOADING, SUCCESS, FAILURE }

class NewCategoryState {
  final String category;
  final String name;
  final NewCategoryStatus status;

  get isValid {
    return category.isNotEmpty && name.isNotEmpty;
  }

  NewCategoryState({required this.category, required this.name, required this.status});

  NewCategoryState copyWith({String? groupId, String? groupName, NewCategoryStatus? status}) {
    return NewCategoryState(
        category: groupId ?? this.category,
        name: groupName ?? this.name,
        status: status ?? this.status
    );
  }
}
