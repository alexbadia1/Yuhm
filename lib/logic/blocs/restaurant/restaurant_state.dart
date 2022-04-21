part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState extends Equatable {}

class RestaurantInitial extends RestaurantState {
  @override
  List<Object?> get props => [];
}

class RestaurantSubmitted extends RestaurantState {
  final String pin;
  RestaurantSubmitted(this.pin);
  @override
  List<Object?> get props => [pin];
}

class RestaurantFetching extends RestaurantState {
  final String pin;
  RestaurantFetching(this.pin);
  @override
  List<Object?> get props => [pin];
}

class RestaurantFetchSuccess extends RestaurantState {
  final Restaurant restaurant;
  RestaurantFetchSuccess(this.restaurant);
  @override
  List<Object?> get props => [restaurant];
}

class RestaurantFetchFailed extends RestaurantState {
  final String msg;
  RestaurantFetchFailed(this.msg);
  @override
  List<Object?> get props => [msg];
}