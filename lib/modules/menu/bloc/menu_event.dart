part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent {}

class LoadMenuItemOfCategory extends MenuEvent {
  final String category;

  LoadMenuItemOfCategory(this.category);
}
