// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

abstract class OrderEvent {}

class CreateOrderEvent extends OrderEvent {
  final Map<int, int> order;
  CreateOrderEvent({
    required this.order,
  });
}

class ReadOrderEvent extends OrderEvent {
  final List<Order> orders;
  ReadOrderEvent({
    required this.orders,
  });
}

class UpdateOrderEvent extends OrderEvent {
  final String id;
  final OrderStatus status;
  UpdateOrderEvent({
    required this.id,
    required this.status,
  });
}

class DeleteOrderEvent extends OrderEvent {
  final String id;
  DeleteOrderEvent({
    required this.id,
  });
}
