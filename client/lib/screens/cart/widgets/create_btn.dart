import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../extension/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../logic/bloc/order/order_bloc.dart';
import '../../../logic/cubit/cart_action/cart_action_cubit.dart';

class CreateBtn extends StatelessWidget {
  const CreateBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartActionCubit, CartActionState>(
      builder: (context, state) {
        return SizedBox(
          width: 35.w,
          height: 5.h,
          child: FloatingActionButton(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                  child: Text(
                'сделать заказ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp),
                textAlign: TextAlign.center,
              )),
            ),
            onPressed: () {
              if (state.finalCart != null) {
                context.read<OrderBloc>().add(CreateOrderEvent(
                    order:
                        state.finalCart!.toString().toMap() as Map<int, int>));
                Navigator.pushReplacementNamed(context, '/order');
                context.read<CartActionCubit>().clearCart();
              }
            },
          ),
        );
      },
    );
  }
}
