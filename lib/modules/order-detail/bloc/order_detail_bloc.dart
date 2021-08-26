import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/models/request/update-order-status-request.dart';
import 'package:thelawala/models/response/order-response.dart';
import 'package:thelawala/utils/helpers/rest-api.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

/// Raise Dispute
/// OPEN -> CONFIRM -> CANCELED
/// CONFIRM -> READY_FOR_PICKUP,
/// READY_FOR_PICKUP -> PICKED_UP,

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final log = Logger('OrderDetailBloc');
  final String orderId;
  final RestApiBuilder api;
  OrderDetailBloc(this.orderId, this.api) : super(OrderDetailState(status: OrderDetailStatus.INITIAL));

  @override
  Stream<OrderDetailState> mapEventToState(
    OrderDetailEvent event,
  ) async* {
    if (event is LoadOrderDetail) {
      yield* _mapLoadOrderDetail();
    } else if (event is UpdateOrderStatus) {
      yield* _mapUpdateOrderStatus(event, state);
    }
  }

  Stream<OrderDetailState> _mapLoadOrderDetail() async* {
    yield state.copyWith(status: OrderDetailStatus.LOADING);
    try {
      RestOptions option = RestOptions(path: '/order/$orderId');
      var resp = await api.get(restOptions: option);
      var parsedResp = api.parsedResponse(resp);
      OrderResponse order = OrderResponse.fromJson(parsedResp);
      yield state.copyWith(order: order, status: OrderDetailStatus.SUCCESS);
    } catch (e) {
      log.severe(e);
      yield state.copyWith(status: OrderDetailStatus.FAILURE);
    }
  }

  Stream<OrderDetailState> _mapUpdateOrderStatus(UpdateOrderStatus event, OrderDetailState state) async* {
    yield state.copyWith(status: OrderDetailStatus.LOADING);
    try {
      UpdateOrderStatusRequest req = UpdateOrderStatusRequest(previousStatus: state.order!.status, status: event.status);
      RestOptions option = RestOptions(path: '/order/$orderId/status', body: json.encode(req));
      var resp = await api.post(restOptions: option);
      OrderResponse _ord = state.order!;
      _ord.status = event.status.toUpperCase();
      // var parsedResp = api.parsedResponse(resp);
      // OrderResponse order = OrderResponse.fromJson(parsedResp);
      yield state.copyWith(order: _ord, status: OrderDetailStatus.SUCCESS);
    } catch (e) {
      log.severe(e);
      yield state.copyWith(status: OrderDetailStatus.FAILURE);
    }
  }
}
