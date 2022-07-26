import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../logic/cubit/cart_action/cart_action_cubit.dart';
import 'widgets/pizza_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Меню',
          style: TextStyle(fontSize: 22.sp, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/order'),
            child: SizedBox(
              height: 50,
              child: Icon(
                Icons.paste_rounded,
                size: 22.sp,
              ),
            ),
          ),
          BlocBuilder<CartActionCubit, CartActionState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/cart'),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Badge(
                    badgeContent: Text(state.cartList.length.toString()),
                    animationType: BadgeAnimationType.scale,
                    animationDuration: const Duration(milliseconds: 200),
                    position: const BadgePosition(end: 1, bottom: 1),
                    child: Icon(Icons.shopping_basket_outlined, size: 22.sp),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 15)
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return const PizzaListWidget();
        },
      ),
    );
  }
}
