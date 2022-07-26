import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/pizza.dart';
import 'package:sizer/sizer.dart';

import '../../../const/const.dart';
import '../../../const/enums.dart';
import '../../../logic/bloc/pizza_list/pizza_list_bloc.dart';
import '../../../logic/cubit/cart_action/cart_action_cubit.dart';
import '../../../logic/cubit/remove_btn/remove_btn_helper_cubit.dart';

class PizzaListWidget extends StatelessWidget {
  const PizzaListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PizzaListBloc, PizzaListState>(
      builder: (context, state) {
        if (state.status == Status.submissionInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == Status.submissionSuccess) {
          List<Pizza>? pizza = state.pizzaList;
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      height: 35.w,
                      width: 35.w,
                      imageUrl: '$url${pizza?[index].id}.png',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                              children: <TextSpan>[
                                const TextSpan(text: 'name - '),
                                TextSpan(
                                  text: pizza?[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                              children: <TextSpan>[
                                const TextSpan(text: 'id - '),
                                TextSpan(
                                  text: pizza?[index].id.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () => context
                                    .read<CartActionCubit>()
                                    .addToCart(pizza![index].id),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 218, 105, 30)),
                                ),
                                child: SizedBox(
                                  width: 25.w,
                                  child: Center(
                                    child: Text(
                                      'в корзину',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                            const SizedBox(width: 5),
                            RemoveFromCartWidget(index: index, pizza: pizza),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: pizza?.length,
            shrinkWrap: true,
          );
        }
        return const Center(child: Text('что то не так'));
      },
    );
  }
}

class RemoveFromCartWidget extends StatelessWidget {
  const RemoveFromCartWidget({
    Key? key,
    required this.pizza,
    required this.index,
  }) : super(key: key);
  final List<Pizza>? pizza;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoveBtnHelperCubit, RemoveBtnHelperState>(
        builder: (context, st) {
      if (st.currentCart!.contains(pizza![index].id)) {
        return ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 214, 172, 58)),
            ),
            onPressed: () =>
                context.read<CartActionCubit>().deleteFromCart(index),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
            ));
      }
      return const SizedBox();
    });
  }
}
