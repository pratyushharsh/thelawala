import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/models/request/new-category-request.dart';
import 'package:thelawala/utils/helpers/rest-api.dart';

part 'new_category_event.dart';
part 'new_category_state.dart';

class NewCategoryBloc extends Bloc<NewCategoryEvent, NewCategoryState> {
  final RestApiBuilder api;
  NewCategoryBloc(this.api) : super(NewCategoryState(name: '', category: '', status: NewCategoryStatus.INITIAL));

  @override
  Stream<NewCategoryState> mapEventToState(
    NewCategoryEvent event,
  ) async* {
    if (event is OnGroupNameChange) {
      yield state.copyWith(groupName: event.value);
    } else if (event is OnGroupIdChange) {
      yield state.copyWith(groupId: event.value);
    } else if (event is SubmitCategory) {
      yield* _mapSubmitToCategory();
    }
  }

  Stream<NewCategoryState> _mapSubmitToCategory() async* {
    try {
      yield state.copyWith(status: NewCategoryStatus.LOADING);
      NewCategoryRequest request = NewCategoryRequest(category: state.category, name: state.name);
      RestOptions option = RestOptions(path: '/category', body: json.encode(request));
      api.post(restOptions: option);
      yield state.copyWith(status: NewCategoryStatus.SUCCESS);
    } catch (e) {
      print(e);
      yield state.copyWith(status: NewCategoryStatus.FAILURE);
    }
  }
} 
