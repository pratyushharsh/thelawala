import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/models/response/category-response.dart';
import 'package:thelawala/utils/helpers/rest-api.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final RestApiBuilder api;

  CategoryBloc(this.api)
      : super(CategoryState(categories: [], status: CategoryStatus.INITIAL));

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is LoadCategories) {
      yield* _mapGetCategories();
    }
  }

  Stream<CategoryState> _mapGetCategories() async* {
    try {
      yield state.copyWith(status: CategoryStatus.LOADING);
      RestOptions options = RestOptions(path: '/category');
      var response = await api.get(restOptions: options);
      List<dynamic> parsedResponse = api.parsedResponse(response) as List;
      List<CategoryResponse> categories =
          parsedResponse.map((e) => CategoryResponse.fromJson(e)).toList();
      yield state.copyWith(status: CategoryStatus.SUCCESS, categories: categories);
    } catch (e) {
      print(e);
      yield state.copyWith(status: CategoryStatus.FAILURE);
    }
  }
}
