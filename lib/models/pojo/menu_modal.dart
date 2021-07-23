class MenuItemModifier {
  final String groupName;
  final bool mustSelect;
  final bool multipleSelectionAllowed;
  final List<ModifierItem> items;

  MenuItemModifier(
      {required this.groupName,
        this.mustSelect = false,
        this.multipleSelectionAllowed = false,
        this.items = const []});

  MenuItemModifier copyWith(
      {String? groupName,
        bool? mustSelect,
        bool? multipleSelectionAllowed,
        List<ModifierItem>? items}) {
    return MenuItemModifier(
        groupName: groupName ?? this.groupName,
        multipleSelectionAllowed: multipleSelectionAllowed ?? this.multipleSelectionAllowed,
        mustSelect: mustSelect ?? this.mustSelect,
        items: items ?? this.items
    );
  }
}

class ModifierItem {
  final String name;
  final double price;

  ModifierItem({required this.name, required this.price });
}