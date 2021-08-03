class NewMenuItemRequest {
  late String itemName;
  late double itemPrice;
  late String description;
  late List<String> tags;
  late bool active;
  late List<RequestModifiers> modifiers;

  NewMenuItemRequest(
      { required this.itemName,
        required this.itemPrice,
        required this.description,
        required this.tags,
        required this.active,
        required this.modifiers});

  NewMenuItemRequest.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    description = json['description'];
    tags = json['tags'].cast<String>();
    active = json['active'];
    if (json['modifiers'] != null) {
      modifiers = List.empty(growable: true);
      json['modifiers'].forEach((v) {
        modifiers.add(new RequestModifiers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['item_price'] = this.itemPrice;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['active'] = this.active;
    data['modifiers'] = this.modifiers.map((v) => v.toJson()).toList();
    return data;
  }
}

class RequestModifiers {
  late String groupName;
  late List<ItemList> itemList;
  late bool mustSelect;
  late bool multipleSelectionAllowed;

  RequestModifiers(
      { required this.groupName,
        required this.itemList,
        required this.mustSelect,
        required this.multipleSelectionAllowed});

  RequestModifiers.fromJson(Map<String, dynamic> json) {
    groupName = json['group_name'];
    if (json['item_list'] != null) {
      itemList = List.empty(growable: true);
      json['item_list'].forEach((v) {
        itemList.add(new ItemList.fromJson(v));
      });
    }
    mustSelect = json['must_select'];
    multipleSelectionAllowed = json['multiple_selection_allowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_name'] = this.groupName;
    if (this.itemList != null) {
      data['item_list'] = this.itemList.map((v) => v.toJson()).toList();
    }
    data['must_select'] = this.mustSelect;
    data['multiple_selection_allowed'] = this.multipleSelectionAllowed;
    return data;
  }
}

class ItemList {
  late String modifierName;
  late double price;

  ItemList({required this.modifierName, required this.price});

  ItemList.fromJson(Map<String, dynamic> json) {
    modifierName = json['modifier_name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modifier_name'] = this.modifierName;
    data['price'] = this.price;
    return data;
  }
}
