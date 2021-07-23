part of 'new_menu_bloc.dart';

class NewMenuState {
  final String item_id;
  final double price;
  final String description;
  final List<String> tags;
  final List<MenuItemModifier> modifier;

  NewMenuState(
      {required this.item_id,
      required this.price,
      required this.description,
      required this.tags,
      required this.modifier});
}


