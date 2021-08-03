part of 'new_menu_bloc.dart';

@immutable
abstract class NewMenuEvent {}

class AddNewModifier extends NewMenuEvent {
  final MenuItemModifier modifier;

  AddNewModifier(this.modifier);
}

class OnItemNameChange extends NewMenuEvent {
  final String name;

  OnItemNameChange(this.name);
}

class OnPriceChange extends NewMenuEvent {
  final String price;
  OnPriceChange(this.price);
}

class OnDescriptionChange extends NewMenuEvent {
  final String description;

  OnDescriptionChange(this.description);
}

class OnActiveChange extends NewMenuEvent {
  final bool active;

  OnActiveChange(this.active);
}

class OnCreateNewMenuItem extends NewMenuEvent {}

class UpdateExistingProduct extends NewMenuEvent {}