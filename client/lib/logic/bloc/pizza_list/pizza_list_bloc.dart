 
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../const/enums.dart';
import '../../../model/pizza.dart';
import '../../../services/rest_api.dart';

part 'pizza_list_event.dart';
part 'pizza_list_state.dart';

class PizzaListBloc extends Bloc<PizzaListEvent, PizzaListState> {
  final RestApi api;
  PizzaListBloc({required this.api}) : super(PizzaListState()) { 
    on<GetPizzaEvent>((event, emit) async {
      emit(state.copyWith(status: Status.submissionInProgress));
      try {
        final pizzaList = await api.getPizzaList();
        emit(state.copyWith(
            pizzaList: pizzaList, status: Status.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(status: Status.submissionFailure));
      }
    });
  }
}
