import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'widgets/order_list.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Заказы',
        style: TextStyle(fontSize: 22.sp),
      )),
      body: const OrderList(),
    );
  }
}
