// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart_action/cart_action_cubit.dart';

part 'remove_btn_helper_state.dart';

class RemoveBtnHelperCubit extends Cubit<RemoveBtnHelperState> {
  CartActionCubit cartCounterCubit;
  late StreamSubscription cartCounterSub;
  RemoveBtnHelperCubit({
    required this.cartCounterCubit,
  }) : super(RemoveBtnHelperState(currentCart: [])) {
    cartCounterSub = cartCounterCubit.stream.listen((e) {
      emit(RemoveBtnHelperState(currentCart: e.cartList.toSet().toList()));
    });
  }

  @override
  Future<void> close() {
    cartCounterCubit.close();
    return super.close();
  }
}
