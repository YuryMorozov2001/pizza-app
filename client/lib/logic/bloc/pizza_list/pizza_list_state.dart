// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pizza_list_bloc.dart';

class PizzaListState {
  List<Pizza>? pizzaList;
  Status status;
  PizzaListState({
    this.pizzaList,
    this.status = Status.empty,
  });
 

  PizzaListState copyWith({
    List<Pizza>? pizzaList,
    Status? status,
  }) {
    return PizzaListState(
      pizzaList: pizzaList ?? this.pizzaList,
      status: status ?? this.status,
    );
  }
}
