import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/models/response/menu-item-response.dart';
import 'package:thelawala/utils/helpers/rest-api.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final RestApiBuilder api;
  MenuBloc(this.api) : super(MenuState(menuItems: List.empty(), status: MenuStatus.INITITAL));

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    if (event is LoadMenuItemOfCategory) {
      yield* _mapLoadMenuItemOfCategory(event);
    }
  }

  Stream<MenuState> _mapLoadMenuItemOfCategory(LoadMenuItemOfCategory event) async* {
    RestOptions options = RestOptions(path: "/menu/${event.category}");
    try {
      yield state.copyWith(status: MenuStatus.LOADING);
      var response = await api.get(restOptions: options);
      List<dynamic> parsedResponse = api.parsedResponse(response) as List;
      List<MenuItemResponse> items =
      parsedResponse.map((e) => MenuItemResponse.fromJson(e)).toList();
      yield state.copyWith(status: MenuStatus.SUCCESS, menuItems: items);
    } catch (e) {
      print(e);
      yield state.copyWith(status: MenuStatus.FAILURE);
    }
  }

}
