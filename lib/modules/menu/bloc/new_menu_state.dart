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
  final File? image;
  final String? imageUrl;

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
      required this.modifier,
      this.image,
      this.imageUrl});

  NewMenuState copyWith(
      {String? name,
      String? price,
      bool? active,
      String? description,
      NewMenuStatus? status,
      List<String>? tags,
      List<MenuItemModifier>? modifier,
      File? image,
      String? imageUrl}) {
    return NewMenuState(
        active: active ?? this.active,
        name: name ?? this.name,
        price: price ?? this.price,
        status: status ?? this.status,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        modifier: modifier ?? this.modifier,
        image: image ?? this.image,
        imageUrl: imageUrl ?? this.imageUrl);
  }
}
