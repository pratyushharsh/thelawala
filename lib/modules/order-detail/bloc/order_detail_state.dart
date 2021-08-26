part of 'order_detail_bloc.dart';

enum OrderDetailStatus { INITIAL, LOADING, SUCCESS, FAILURE }

class OrderDetailState {
  final OrderDetailStatus status;
  final OrderResponse? order;

  OrderDetailState({required this.status, this.order});

  OrderDetailState copyWith({OrderDetailStatus? status, OrderResponse? order}) {
    return OrderDetailState(
        status: status ?? this.status, order: order ?? this.order);
  }
}
