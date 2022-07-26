import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/ws_api.dart';

import '../../../const/enums.dart';
import '../../../model/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final WebSocketApi api;
  late StreamSubscription _streamSubscription;
  OrderBloc({required this.api}) : super(OrderState()) {
    _streamSubscription = api.stream.listen((orders) {
      final decoded = json.decode(orders) as List;
      final res = decoded.map<Order>((json) => Order.fromJson(json)).toList();
      add(ReadOrderEvent(orders: res));
    });
    api.send(json.encode({'action': ''}));
    on<CreateOrderEvent>((event, emit) {
      api.send(json.encode({'action': 'ADD', 'payload': '${event.order}', 'status': 'OrderStatus.creationInProggress'}));
    });
    on<ReadOrderEvent>((event, emit) {
      emit(state.copyWith(orders: event.orders));
    });
    on<UpdateOrderEvent>((event, emit) {
      api.send(json.encode(
          {'action': 'UPDATE', 'payload': event.id, 'status': '${event.status}'}));
    });
    on<DeleteOrderEvent>((event, emit) {
      api.send(json.encode({'action': 'DELETE', 'payload': event.id}));
    });
  }
  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
