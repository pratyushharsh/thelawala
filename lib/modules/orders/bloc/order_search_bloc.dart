import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/models/response/order-search-response.dart';
import 'package:thelawala/utils/helpers/rest-api.dart';

part 'order_search_event.dart';
part 'order_search_state.dart';

class OrderSearchBloc extends Bloc<OrderSearchEvent, OrderSearchState> {
  final RestApiBuilder api;
  final log = Logger('OrderSearchBloc');
  OrderSearchBloc(this.api) : super(OrderSearchState(status: OrderSearchStatus.INITIAL, orders: List.empty()));

  @override
  Stream<OrderSearchState> mapEventToState(
    OrderSearchEvent event,
  ) async* {
    if (event is LoadUserOrders) {
      yield* _mapOrderSearchResult();
    }
  }

  Stream<OrderSearchState> _mapOrderSearchResult() async* {
    yield state.copyWith(status: OrderSearchStatus.LOADING);
    RestOptions options = RestOptions(path: "/order");
    try {
      var response = await api.get(restOptions: options);
      List<dynamic> parsedResponse = api.parsedResponse(response) as List;
      List<OrderSearchResponse> items =
      parsedResponse.map((e) => OrderSearchResponse.fromJson(e)).toList();
      yield state.copyWith(orders: items, status: OrderSearchStatus.SUCCESS);
    } catch (e) {
      log.severe(e);
      yield state.copyWith(status: OrderSearchStatus.FAILURE);
    }
  }
}
