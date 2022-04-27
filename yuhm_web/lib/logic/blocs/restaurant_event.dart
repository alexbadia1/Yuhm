part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent {
  final Restaurant restaurant;
  const RestaurantEvent(this.restaurant);
}

class SubmitRestaurant extends RestaurantEvent {
  final Restaurant newRestaurant;
  const SubmitRestaurant(this.newRestaurant) : super(newRestaurant);
}

class UpdateRestaurant extends RestaurantEvent {
  final Restaurant newRestaurant;
  const UpdateRestaurant(this.newRestaurant) : super(newRestaurant);
}