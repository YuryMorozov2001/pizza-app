// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_action_cubit.dart';

class CartActionState {
  List<int> cartList;
  Map? finalCart;
  CartActionState({
    required this.cartList,
    this.finalCart,
  });
}
