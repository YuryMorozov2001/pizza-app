import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../const/const.dart';
import '../../../logic/bloc/pizza_list/pizza_list_bloc.dart';
import '../../../logic/cubit/cart_action/cart_action_cubit.dart';
import 'remove_btn.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartActionCubit, CartActionState>(
      builder: (context, state) {
        final cart = state.finalCart;
        if (state.cartList.isNotEmpty) {
          return ListView.builder(
            itemCount: state.finalCart!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16),
                child: Row(
                  children: [
                    Text(
                      '${index + 1}.',
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    CachedNetworkImage(
                      height: 26.w,
                      width: 26.w,
                      imageUrl: '$url${cart!.keys.toList()[index]}.png',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(width: 5),
                    BlocBuilder<PizzaListBloc, PizzaListState>(
                      builder: (context, pizzaState) {
                        final pizzaList = pizzaState.pizzaList;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                                      children: <TextSpan>[
                                        const TextSpan(text: 'название: '),
                                        TextSpan(
                                          text: pizzaList![
                                                  cart.keys.toList()[index] - 1]
                                              .name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'кол-во: ',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  cart.values.toList()[index].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                RemoveBtn(
                                  onTap: () => context
                                      .read<CartActionCubit>()
                                      .deleteFromCart(state.finalCart!.keys
                                              .toList()[index] -
                                          1),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Center(
            child: Text(
          'корзина пустая',
          style: TextStyle(fontSize: 16.sp),
        ));
      },
    );
  }
}
