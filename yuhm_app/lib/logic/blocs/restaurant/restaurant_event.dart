part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent {}

class FetchRestaurant extends RestaurantEvent {
  final String pin;
  FetchRestaurant(this.pin);
}

class UpdateRestaurant extends RestaurantEvent {
  final Restaurant restaurant;
  UpdateRestaurant(this.restaurant);
}