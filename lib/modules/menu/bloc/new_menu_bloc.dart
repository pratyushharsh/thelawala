import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/models/pojo/menu_modal.dart';

part 'new_menu_event.dart';
part 'new_menu_state.dart';

class NewMenuBloc extends Bloc<NewMenuEvent, NewMenuState> {
  NewMenuBloc() : super(NewMenuState(item_id: '', price: 0.00, description: '', tags: [], modifier: []));

  @override
  Stream<NewMenuState> mapEventToState(
    NewMenuEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
