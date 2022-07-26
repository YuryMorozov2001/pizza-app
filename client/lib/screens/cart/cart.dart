import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'widgets/cart_list.dart';
import 'widgets/create_btn.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Корзина',
        style: TextStyle(fontSize: 22.sp),
      )),
      floatingActionButton: const CreateBtn(),
      body: const CartList(),
    );
  }
}
