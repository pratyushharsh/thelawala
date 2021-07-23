part of 'item_modifier_bloc.dart';

@immutable
abstract class ItemModifierEvent {}

class OnGroupNameChange extends ItemModifierEvent {
  final String groupName;

  OnGroupNameChange(this.groupName);
}

class AddNewItemModifier extends ItemModifierEvent {
  final String name;
  final double price;

  AddNewItemModifier({ required this.name, required this.price});
}

class DeleteItemModifier extends ItemModifierEvent {
  final ModifierItem item;

  DeleteItemModifier(this.item);
}

class OnMustSelectChange extends ItemModifierEvent {
  final bool value;

  OnMustSelectChange(this.value);
}

class OnAllowMultiSelectChange extends ItemModifierEvent {
  final bool value;

  OnAllowMultiSelectChange(this.value);
}