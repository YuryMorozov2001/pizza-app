import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../const/enums.dart';
import '../../../logic/bloc/order/order_bloc.dart';

class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return PopupMenuButton(
            splashRadius: 1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            onSelected: (result) async {
              if (result == 0) {
                context.read<OrderBloc>().add(UpdateOrderEvent(
                    id: state.orders![index].id.toString(),
                    status: OrderStatus.readyForDelivery));
              }
              if (result == 1) {
                context.read<OrderBloc>().add(UpdateOrderEvent(
                    id: state.orders![index].id.toString(),
                    status: OrderStatus.issued));
              }
              if (result == 2) {
                context.read<OrderBloc>().add(
                    DeleteOrderEvent(id: state.orders![index].id.toString()));
              }
            },
            itemBuilder: (context) => [
                  const PopupMenuItem(value: 0, child: Text('к выдаче')),
                  const PopupMenuItem(value: 1, child: Text('выдан')),
                  const PopupMenuItem(value: 2, child: Text('удалить')),
                ]);
      },
    );
  }
}
