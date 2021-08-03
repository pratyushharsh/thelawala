part of 'new_menu_bloc.dart';

enum NewMenuStatus { INITIAL, LOADING, SUCCESS, FAILURE }

class NewMenuState {
  final String name;
  final String price;
  final String description;
  final List<String> tags;
  final List<MenuItemModifier> modifier;
  final bool active;
  final NewMenuStatus status;

  get isValid {
    bool _isValid = true;

    if (name.isEmpty || description.isEmpty || price.isEmpty) {
      _isValid = false;
    }

    return _isValid;
  }

  NewMenuState(
      {required this.name,
      required this.active,
      required this.price,
      required this.description,
      required this.tags,
      required this.status,
      required this.modifier});

  NewMenuState copyWith(
      {String? name,
      String? price,
      bool? active,
      String? description,
      NewMenuStatus? status,
      List<String>? tags,
      List<MenuItemModifier>? modifier}) {
    return NewMenuState(
        active: active ?? this.active,
        name: name ?? this.name,
        price: price ?? this.price,
        status: status ?? this.status,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        modifier: modifier ?? this.modifier);
  }
}
