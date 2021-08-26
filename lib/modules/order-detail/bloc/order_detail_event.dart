part of 'order_detail_bloc.dart';

@immutable
abstract class OrderDetailEvent {}

class LoadOrderDetail extends OrderDetailEvent {}

class UpdateOrderStatus extends OrderDetailEvent {
  final String status;

  UpdateOrderStatus(this.status);
}

