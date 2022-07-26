import 'package:flutter_bloc/flutter_bloc.dart';


part 'cart_action_state.dart';

class CartActionCubit extends Cubit<CartActionState> {
  CartActionCubit() : super(CartActionState(cartList: []));

  addToCart(int pizzaId) {
    List<int> newCartList = state.cartList;
    newCartList.add(pizzaId);
    newCartList.sort();

    emit(CartActionState(
        cartList: newCartList, finalCart: mapGenerate(newCartList)));
  }

  deleteFromCart(id) {
    List<int> newCartList = state.cartList;
    newCartList.remove(id + 1); 
    emit(CartActionState(
        cartList: newCartList, finalCart: mapGenerate(newCartList)));
  }

  clearCart() {
    emit(CartActionState(cartList: [], finalCart: null));
  }

  Map mapGenerate(cartList) {
    List<int> currCartList = cartList;

    Map cart = {};
    var counter = 0;
    for (int i = 0; i < currCartList.length; i++) {
      if (i != currCartList.length - 1) {
        if (currCartList[i] != currCartList[i + 1]) {
          counter++;
          cart[currCartList[i]] = counter;
          counter = 0;
        } else {
          counter++;
        }
      }
      if (i == currCartList.length - 1) {
        counter++;
        cart[currCartList[i]] = counter;
      }
    }
    return cart;
  }
}
