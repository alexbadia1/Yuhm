part of 'order_bloc.dart';

abstract class OrderEvent {
  const OrderEvent();
}

class SubmitOrder extends OrderEvent {
  final Order order;
  final ScaffoldMessengerState? scaffoldMessengerState;
  final AppPageViewCubit? appPageViewCubit;
  SubmitOrder(this.order, {this.scaffoldMessengerState, this.appPageViewCubit});
}
