import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../extension/extensions.dart';
import 'popup_menu.dart';
import 'package:sizer/sizer.dart';

import '../../../const/enums.dart';
import '../../../logic/bloc/order/order_bloc.dart';
import '../../../logic/bloc/pizza_list/pizza_list_bloc.dart';
import '../../../model/order.dart';
import '../../../model/pizza.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          final List<Order>? orders = state.orders;
          if (orders != null) {
            return ListView.builder(
              itemBuilder: ((context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: 16.0,
                      top: 8.0,
                      right: 16.0,
                      bottom: index + 1 == orders.length ? 8.0 : 0.0),
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderTopBarWidget(
                          orders: orders,
                          index: index,
                        ),
                        OrderStatusWidget(
                          orders: orders,
                          index: index,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              itemCount: orders.length,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class OrderTopBarWidget extends StatelessWidget {
  const OrderTopBarWidget({
    Key? key,
    required this.orders,
    required this.index,
  }) : super(key: key);

  final List<Order>? orders;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                orders![index].id,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              const Spacer(),
              SizedBox(width: 30, child: PopUpMenuWidget(index: index)),
            ],
          ),
          OrderContentWidget(orders: orders, index: index),
        ],
      ),
    );
  }
}

class OrderContentWidget extends StatelessWidget {
  const OrderContentWidget({
    Key? key,
    required this.orders,
    required this.index,
  }) : super(key: key);

  final List<Order>? orders;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
      child: Column(
        children: [
          const Divider(thickness: 2),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index1) {
              return BlocBuilder<PizzaListBloc, PizzaListState>(
                builder: (context, state1) {
                  List<Pizza>? pizza = state1.pizzaList;
                  if (state1.status == Status.submissionInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state1.status == Status.submissionSuccess) {
                    return Row(
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                children: [
                              TextSpan(
                                  text:
                                      '${pizza![orders![index].items.keyAt(index1) - 1].name} x '),
                              TextSpan(
                                text: '${orders![index].items.valueAt(index1)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ])),
                      ],
                    );
                  }
                  return const Text('что то не так');
                },
              );
            },
            itemCount: orders![index].items.length,
          ),
        ],
      ),
    );
  }
}

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    Key? key,
    required this.orders,
    required this.index,
  }) : super(key: key);

  final List<Order>? orders;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: (orders![index].status != OrderStatus.creationInProggress
              ? (orders![index].status == OrderStatus.readyForDelivery
                  ? Colors.green
                  : Colors.grey)
              : Colors.orange),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          orders![index].status != OrderStatus.creationInProggress
              ? (orders![index].status == OrderStatus.readyForDelivery
                  ? 'готов к выдаче'
                  : 'выдан')
              : 'готовится',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: (orders![index].status != OrderStatus.creationInProggress
                  ? (orders![index].status == OrderStatus.readyForDelivery
                      ? Colors.white
                      : Colors.white)
                  : Colors.black)),
        ),
      )),
    );
  }
}
