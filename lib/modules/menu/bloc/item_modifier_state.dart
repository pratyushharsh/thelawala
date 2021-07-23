part of 'item_modifier_bloc.dart';

class ItemModifierState {
  final String groupName;
  final bool mustSelect;
  final bool multipleSelectionAllowed;
  final List<ModifierItem> items;

  ItemModifierState(
      {required this.groupName,
      required this.mustSelect,
      required this.multipleSelectionAllowed,
      this.items = const []});

  ItemModifierState copyWith(
      {String? groupName,
      bool? mustSelect,
      bool? multipleSelectionAllowed,
      List<ModifierItem>? items}) {
    return ItemModifierState(
        groupName: groupName ?? this.groupName,
        mustSelect: mustSelect ?? this.mustSelect,
        multipleSelectionAllowed:
            multipleSelectionAllowed ?? this.multipleSelectionAllowed,
    items: items ?? this.items);
  }
}
