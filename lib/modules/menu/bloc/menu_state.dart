part of 'menu_bloc.dart';

enum MenuStatus { INITITAL, LOADING, FAILURE, SUCCESS }

class MenuState {
  final List<MenuItemResponse> menuItems;
  final MenuStatus status;

  MenuState({required this.menuItems, required this.status});

  MenuState copyWith({List<MenuItemResponse>? menuItems, MenuStatus? status}) {
    return MenuState(
      menuItems: menuItems ?? this.menuItems,
      status: status ?? this.status,
    );
  }
}
