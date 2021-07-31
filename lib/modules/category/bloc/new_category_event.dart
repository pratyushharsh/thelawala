part of 'new_category_bloc.dart';

@immutable
abstract class NewCategoryEvent {}

class OnGroupIdChange extends NewCategoryEvent {
  final String value;

  OnGroupIdChange(this.value);
}

class OnGroupNameChange extends NewCategoryEvent {
  final String value;

  OnGroupNameChange(this.value);
}

class SubmitCategory extends NewCategoryEvent {}