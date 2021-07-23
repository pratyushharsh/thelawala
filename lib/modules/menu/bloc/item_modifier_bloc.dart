import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/models/pojo/menu_modal.dart';

part 'item_modifier_event.dart';
part 'item_modifier_state.dart';

class ItemModifierBloc extends Bloc<ItemModifierEvent, ItemModifierState> {
  ItemModifierBloc()
      : super(ItemModifierState(
            groupName: '', mustSelect: false, multipleSelectionAllowed: false));

  @override
  Stream<ItemModifierState> mapEventToState(
    ItemModifierEvent event,
  ) async* {
    if (event is OnGroupNameChange) {
      yield state.copyWith(groupName: event.groupName);
    } else if (event is AddNewItemModifier) {
      List<ModifierItem> newItems = [
        ...state.items,
        ModifierItem(name: event.name, price: event.price)
      ];
      yield state.copyWith(items: newItems);
    } else if (event is DeleteItemModifier) {
      state.items.remove(event.item);
      List<ModifierItem> newItems = [...state.items];
      yield state.copyWith(items: newItems);
    } else if (event is OnAllowMultiSelectChange) {
      yield state.copyWith(multipleSelectionAllowed: event.value);
    } else if (event is OnMustSelectChange) {
      yield state.copyWith(mustSelect: event.value);
    }
  }
}
