import 'package:flutter/material.dart'; 
import '../screens/order/order.dart'; 

import '../screens/cart/cart.dart';
import '../screens/home/home.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartPage());
      case '/order':
        return MaterialPageRoute(builder: (_) => const OrderPage());
    }
    return null;
  }
}
