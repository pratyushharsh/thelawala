import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/models/pojo/menu_modal.dart';

part 'new_menu_event.dart';
part 'new_menu_state.dart';

class NewMenuBloc extends Bloc<NewMenuEvent, NewMenuState> {
  NewMenuBloc() : super(NewMenuState(name: '', price: 0.00, description: '', active: false, tags: [], modifier: [], status: NewMenuStatus.INITIAL));

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

    }
  }
}
