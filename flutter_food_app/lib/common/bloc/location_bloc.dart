import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/location_event.dart';
import 'package:flutter_food_app/common/state/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  void addLocation(List<String> nameCities, List<List<String>> nameProvinces) {
    dispatch(AddLocation(nameCities, nameProvinces));
  }

  @override
  // TODO: implement initialState
  LocationState get initialState => LocationState.initial();

  @override
  Stream<LocationState> mapEventToState(
      LocationState currentState, LocationEvent event) async* {
    // TODO: implement mapEventToState
    if (event is AddLocation) {
      yield LocationState(
        nameCities: event.nameCities,
        nameProvinces: event.nameProvinces,
      );
    }
  }
}
