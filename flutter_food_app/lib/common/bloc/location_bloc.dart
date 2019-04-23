import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/location_event.dart';
import 'package:flutter_food_app/common/state/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  void addLocation(List<String> nameCities, List<List<String>> nameProvinces) {
    dispatch(AddLocation(nameCities, nameProvinces));
  }

  void changeLocation(int indexCity, int indexProvince) {
    dispatch(ChangeLocation(indexCity, indexProvince));
  }

  void changeTemp(int tempCity, int tempProvince) {
    dispatch(ChangeTemp(tempCity, tempProvince));
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
        indexCity: currentState.indexCity,
        indexProvince: currentState.indexProvince,
        tempCity: currentState.tempCity,
        tempProvince: currentState.indexProvince,
      );
    }
    if (event is ChangeLocation) {
      yield LocationState(
        nameCities: currentState.nameCities,
        nameProvinces: currentState.nameProvinces,
        indexCity: event.indexCity,
        indexProvince: event.indexProvince,
        tempCity: currentState.tempCity,
        tempProvince: currentState.indexProvince,
      );
    }

    if (event is ChangeTemp) {
      yield LocationState(
        nameCities: currentState.nameCities,
        nameProvinces: currentState.nameProvinces,
        indexCity: currentState.indexCity,
        indexProvince: currentState.indexProvince,
        tempCity: event.tempCity,
        tempProvince: event.tempProvince,
      );
    }
  }
}
