import 'package:yuhm/logic/logic.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<FetchRestaurant>((event, emit) => _fetchRestaurant(emit, event.pin));
    on<UpdateRestaurant>(
          (event, emit) => _updateRestaurant(emit, event.restaurant),
    );
  }

  void _fetchRestaurant(Emitter<RestaurantState> emit, String pin) async {
    emit(RestaurantFetching(pin));
    await Future.delayed(const Duration(milliseconds: 800));
    emit(
      RestaurantFetchSuccess(
        Restaurant.MckinneyAndDoyle(
          menus: [const Menu.drinks()],
        ),
      ),
    );
  }

  void _updateRestaurant(Emitter<RestaurantState> emit, Restaurant r) {
    emit(RestaurantFetchSuccess(r));
  }
}
