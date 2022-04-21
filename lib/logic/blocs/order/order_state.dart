part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderValid extends OrderState {
  final Order order;
  OrderValid(this.order);
  @override
  List<Object> get props => [order];
}

class OrderInvalid extends OrderState {
  final Order order;
  final String reason;
  OrderInvalid(this.order, this.reason);
  @override
  List<Object> get props => [order];
}
