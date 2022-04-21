part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent extends Equatable {}

class FetchRestaurant extends RestaurantEvent {
  final String pin;
  FetchRestaurant(this.pin);
  
  @override
  List<Object?> get props => [pin];
}

class UpdateRestaurant extends RestaurantEvent {
  final Restaurant restaurant;
  UpdateRestaurant(this.restaurant);

  @override
  List<Object?> get props => [restaurant];
}