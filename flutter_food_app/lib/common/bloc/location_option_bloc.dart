import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/location_option_event.dart';
import 'package:flutter_food_app/common/state/location_option_state.dart';

class LocationOptionBloc extends Bloc<LocationOptionEvent, LocationOptionState> {
  void changeLocation(int indexCity, int indexProvince) {
    dispatch(ChangeLocationOption(indexCity, indexProvince));
  }

  @override
  // TODO: implement initialState
  LocationOptionState get initialState => LocationOptionState.initial();

  @override
  Stream<LocationOptionState> mapEventToState(LocationOptionState currentState, LocationOptionEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ChangeLocationOption) {
      yield LocationOptionState(
        indexCity: event.indexCity,
        indexProvince: event.indexProvince
      );
    }
  }
}
