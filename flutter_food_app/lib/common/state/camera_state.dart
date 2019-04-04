import 'package:camera/camera.dart';

class CameraState{
  final List<CameraDescription> cameras;

  const CameraState({this.cameras});

  factory CameraState.initial() => CameraState(cameras: [
  ]);
}