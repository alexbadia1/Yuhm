part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState extends Equatable {
  final Restaurant restaurant;
  const RestaurantState(this.restaurant);

  @override
  List<Object?> get props => [restaurant];
}

class RestaurantInitial extends RestaurantState {
  final Restaurant newRestaurant;
  const RestaurantInitial(this.newRestaurant) : super(newRestaurant);
}

class RestaurantSubmitting extends RestaurantState {
  final Restaurant newRestaurant;
  const RestaurantSubmitting(this.newRestaurant) : super(newRestaurant);
}

class RestaurantSubmitSuccess extends RestaurantState {
  final Restaurant newRestaurant;
  const RestaurantSubmitSuccess(this.newRestaurant) : super(newRestaurant);
}

class RestaurantSubmitFailed extends RestaurantState {
  final String msg;
  final Restaurant newRestaurant;

  const RestaurantSubmitFailed(this.msg, this.newRestaurant)
      : super(newRestaurant);

  @override
  List<Object?> get props => [msg, newRestaurant];
}