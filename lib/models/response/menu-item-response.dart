class MenuItemResponse {
  late String vendorid;
  late String category;
  late String itemid;
  late String name;
  late double price;
  late String description;
  late List<String> tags;
  late bool active;
  late List<ResponseModifiers> modifiers;

  MenuItemResponse(
      { required this.vendorid,
        required this.category,
        required this.itemid,
        required this.name,
        required this.price,
        required this.description,
        required this.tags,
        required this.active,
        required this.modifiers});

  MenuItemResponse.fromJson(Map<String, dynamic> json) {
    vendorid = json['vendorid'];
    category = json['category'];
    itemid = json['itemid'];
    name = json['name'];
    price = json['price'].toDouble();
    description = json['description'];
    tags = json['tags'].cast<String>();
    active = json['active'];
    if (json['modifiers'] != null) {
      modifiers = List.empty(growable: true);
      json['modifiers'].forEach((v) {
        modifiers.add(ResponseModifiers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['vendorid'] = this.vendorid;
    data['category'] = this.category;
    data['itemid'] = this.itemid;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['active'] = this.active;
    if (this.modifiers != null) {
      data['modifiers'] = this.modifiers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseModifiers {
  late String groupName;
  late bool mustSelect;
  late bool multipleSelectionAllowed;
  late List<ResponseModifierItems> modifierItems;

  ResponseModifiers(
      { required this.groupName,
        required this.mustSelect,
        required this.multipleSelectionAllowed,
        required this.modifierItems});

  ResponseModifiers.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    mustSelect = json['mustSelect'];
    multipleSelectionAllowed = json['multipleSelectionAllowed'];
    if (json['modifierItems'] != null) {
      modifierItems = List.empty(growable: true);
      json['modifierItems'].forEach((v) {
        modifierItems.add(new ResponseModifierItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['mustSelect'] = this.mustSelect;
    data['multipleSelectionAllowed'] = this.multipleSelectionAllowed;
    data['modifierItems'] =
        this.modifierItems.map((v) => v.toJson()).toList();
    return data;
  }
}

class ResponseModifierItems {
  late String itemName;
  late double price;

  ResponseModifierItems({required this.itemName, required  this.price});

  ResponseModifierItems.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['price'] = this.price;
    return data;
  }
}
