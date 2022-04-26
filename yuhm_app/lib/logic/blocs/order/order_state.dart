part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderSent extends OrderState {
  final Order order;
  const OrderSent(this.order);
  @override
  List<Object?> get props => [order];
}

class OrderSentSuccess extends OrderState {
  final Order order;
  const OrderSentSuccess(this.order);
  @override
  List<Object?> get props => [order];
}

class OrderSentFailed extends OrderState {
  final Order order;
  const OrderSentFailed(this.order);
  @override
  List<Object?> get props => [order];
}
