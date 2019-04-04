import 'package:camera/camera.dart';

abstract class CameraEvent{}

class InitCamera extends CameraEvent{
  final List<CameraDescription> cameras;
  InitCamera(this.cameras);
}
