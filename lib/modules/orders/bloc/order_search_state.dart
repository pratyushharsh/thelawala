part of 'order_search_bloc.dart';

enum OrderSearchStatus { INITIAL, LOADING, SUCCESS, FAILURE }

class OrderSearchState {
  final List<OrderSearchResponse> orders;
  final OrderSearchStatus status;

  OrderSearchState({required this.orders, required this.status});

  OrderSearchState copyWith(
      {List<OrderSearchResponse>? orders, OrderSearchStatus? status}) {
    return OrderSearchState(
        orders: orders ?? this.orders, status: status ?? this.status);
  }
}
