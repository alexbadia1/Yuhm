import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yuhm_web/logic/models/restaurant.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial(Restaurant.nullConstructor())) {
    on<SubmitRestaurant>((event, emit) => _fetchRestaurant(emit, event.restaurant));
    on<UpdateRestaurant>((event, emit) => _updateRestaurant(emit, event.restaurant),
    );
  }

  void _fetchRestaurant(Emitter<RestaurantState> emit, Restaurant restaurant) async {
    emit(RestaurantSubmitting(restaurant));

    // Send POST request to database
    await Future.delayed(const Duration(milliseconds: 1000));

  }

  void _updateRestaurant(Emitter<RestaurantState> emit, Restaurant r) {
    final currState = state;
    if (currState is RestaurantInitial) {
      emit(RestaurantInitial(r));
    } else if (currState is RestaurantSubmitting) {
      emit(RestaurantSubmitting(r));
    } else if (currState is RestaurantSubmitSuccess) {
      emit(RestaurantSubmitSuccess(r));
    } else if (currState is RestaurantSubmitFailed) {
      emit(RestaurantSubmitFailed(currState.msg, r));
    }
  }
}
