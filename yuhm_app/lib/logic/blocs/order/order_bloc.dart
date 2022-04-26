import 'package:flutter/material.dart';
import 'package:yuhm_app/logic/logic.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<SubmitOrder>((event, emit) => sendOrder(event, emit));
  }

  Future<void> sendOrder(SubmitOrder event, Emitter<OrderState> emit) async {
    emit(OrderSent(event.order));
    event.scaffoldMessengerState!.showSnackBar(
      const SnackBar(
        content: Text("Sending order..."),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 800));
    emit(OrderSentSuccess(event.order));
    event.scaffoldMessengerState!.hideCurrentSnackBar();
    event.scaffoldMessengerState!.showSnackBar(
      const SnackBar(
        content: Text("Alex, your order was successfully sent!"),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 300));
    event.appPageViewCubit!.jumpToRestaurantPage();
  }
}
