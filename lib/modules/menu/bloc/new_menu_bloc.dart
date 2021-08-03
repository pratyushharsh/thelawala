import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/models/pojo/menu_modal.dart';
import 'package:thelawala/models/request/new-menu-item-request.dart';
import 'package:thelawala/models/response/menu-item-response.dart';
import 'package:thelawala/utils/helpers/rest-api.dart';

part 'new_menu_event.dart';
part 'new_menu_state.dart';

MenuItemModifier transform(ResponseModifiers mod) {
  List<ModifierItem> _items = mod.modifierItems
      .map((e) => ModifierItem(name: e.itemName, price: e.price))
      .toList();
  return MenuItemModifier(
      groupName: mod.groupName,
      mustSelect: mod.mustSelect,
      multipleSelectionAllowed: mod.multipleSelectionAllowed,  items: _items);
}

class NewMenuBloc extends Bloc<NewMenuEvent, NewMenuState> {
  final RestApiBuilder api;
  final String category;
  final MenuItemResponse? existingItem;
  NewMenuBloc(this.api, this.category, {this.existingItem})
      : super(NewMenuState(
            name: existingItem?.name ?? '',
            price: existingItem?.price.toString() ?? '',
            description: existingItem?.description ?? '',
            active: existingItem?.active ?? false,
            tags: existingItem?.tags ?? [],
            modifier:
                existingItem?.modifiers.map((e) => transform(e)).toList() ?? [],
            status: NewMenuStatus.INITIAL));

  @override
  Stream<NewMenuState> mapEventToState(
    NewMenuEvent event,
  ) async* {
    if (event is AddNewModifier) {
      List<MenuItemModifier> modifier = [...state.modifier, event.modifier];
      yield state.copyWith(modifier: modifier);
    } else if (event is OnPriceChange) {
      yield state.copyWith(price: event.price);
    } else if (event is OnItemNameChange) {
      yield state.copyWith(name: event.name);
    } else if (event is OnDescriptionChange) {
      yield state.copyWith(description: event.description);
    } else if (event is OnActiveChange) {
      yield state.copyWith(active: event.active);
    } else if (event is OnCreateNewMenuItem) {
      yield* _mapNewMenuItem(state);
    }
  }

  Stream<NewMenuState> _mapNewMenuItem(NewMenuState state) async* {
    try {
      yield state.copyWith(status: NewMenuStatus.LOADING);
      List<RequestModifiers> modifiers = state.modifier
          .map((e) => RequestModifiers(
              itemList: e.items
                  .map((e) => ItemList(price: e.price, modifierName: e.name))
                  .toList(),
              multipleSelectionAllowed: e.multipleSelectionAllowed,
              groupName: e.groupName,
              mustSelect: e.mustSelect))
          .toList();
      NewMenuItemRequest req = NewMenuItemRequest(
          itemName: state.name,
          itemPrice: double.parse(state.price),
          description: state.description,
          tags: state.tags,
          active: state.active,
          modifiers: modifiers);

      // await Future.delayed(Duration(seconds: 5));
      RestOptions options =
          RestOptions(path: "/menu/$category", body: json.encode(req));
      Response response = await api.post(restOptions: options);
      print(response);
      yield state.copyWith(status: NewMenuStatus.SUCCESS);
    } catch (e) {
      print(e);
      yield state.copyWith(status: NewMenuStatus.FAILURE);
    }
  }
}
