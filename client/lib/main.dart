import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'logic/bloc/order/order_bloc.dart';
import 'logic/bloc/pizza_list/pizza_list_bloc.dart';
import 'logic/cubit/cart_action/cart_action_cubit.dart';
import 'logic/cubit/remove_btn/remove_btn_helper_cubit.dart';
import 'router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/rest_api.dart';
import 'services/ws_api.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(
  DevicePreview(
    enabled: true,
    builder: (context) => MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();
  final CartActionCubit cartCounterCubit = CartActionCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PizzaListBloc>(
              create: (context) =>
                  PizzaListBloc(api: RestApi())..add(GetPizzaEvent())),
          BlocProvider<CartActionCubit>(create: (context) => cartCounterCubit),
          BlocProvider<RemoveBtnHelperCubit>(
            create: (context) =>
                RemoveBtnHelperCubit(cartCounterCubit: cartCounterCubit),
          ),
          BlocProvider<OrderBloc>(
            create: (context) => OrderBloc(api: WebSocketApi()),
          ),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              primarySwatch: Colors.orange,
            ),
            onGenerateRoute: _appRouter.onGenerateRoute,
          );
        }));
  }
}
