import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/camera_bloc.dart';
import 'info/info.dart';

class CameraPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  CameraController controller;
  Color colorNext = Colors.white30;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    controller = CameraController(BlocProvider.of<CameraBloc>(context).currentState.cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (controller == null || !controller.value.isInitialized)
    ? Container(
      color: Colors.black,
    )
    : Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: _captureControlRowTopWidget(),
          ),
        ),
        Center(
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              child: Center(
                child: _captureControlRowBottomWidget(),
              )
          ),
        ),
      ],
    );
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return Container(
        color: Colors.black,
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  Widget _captureControlRowTopWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24,
          ),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: Text(
            'Tiếp tục',
            style: TextStyle(
              color: colorNext,
              fontSize: 17,
              decoration: TextDecoration.none,
            ),
          ),
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => InfoPost()));
          },
        ),
      ],
    );
  }

  Widget _captureControlRowBottomWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        GestureDetector(
          child: Icon(
            Icons.image,
            color: Colors.white,
            size: 24,
          ),
        ),
        GestureDetector(
          child: Icon(
            Icons.camera,
            color: Colors.white,
            size: 50,
          ),
          onTap: (){
            setState(() {
              colorNext = Colors.white;
            });
          },
        ),
        GestureDetector(
          child: Icon(
            Icons.cached,
            color: Colors.white,
            size: 24,
          ),
        )
      ],
    );
  }
}
