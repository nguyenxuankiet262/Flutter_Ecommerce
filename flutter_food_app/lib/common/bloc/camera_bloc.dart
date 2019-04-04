import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter_food_app/common/event/camera_event.dart';
import 'package:flutter_food_app/common/state/camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  void initCamera(List<CameraDescription> cameras) {
    dispatch(InitCamera(cameras));
  }


  @override
  // TODO: implement initialState
  CameraState get initialState => CameraState.initial();

  @override
  Stream<CameraState> mapEventToState(CameraState currentState, CameraEvent event) async* {
    // TODO: implement mapEventToState
    if (event is InitCamera) {
      yield CameraState(
        cameras: event.cameras
      );
    }
  }
}
