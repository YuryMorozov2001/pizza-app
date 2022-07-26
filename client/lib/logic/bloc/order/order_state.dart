// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

class OrderState {
  Status status;
  List<Order>? orders;
  OrderState({
    this.status = Status.empty,
    this.orders,
  });

  OrderState copyWith({
    Status? status,
    List<Order>? orders,
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
    );
  }
}
