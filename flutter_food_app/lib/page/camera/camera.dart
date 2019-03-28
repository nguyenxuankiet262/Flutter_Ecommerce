import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'info/info.dart';

class CameraPage extends StatefulWidget {
  List<CameraDescription> cameras;
  CameraPage(this.cameras);

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
    controller = CameraController(widget.cameras[0], ResolutionPreset.high);
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
    final size = MediaQuery
        .of(context)
        .size;
    final deviceRatio = size.width / size.height;
    return Stack(
      children: <Widget>[
        Center(
          child: _cameraPreviewWidget(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _captureControlRowBottomWidget(),
          ),
        ),
        Padding(
          child: GestureDetector(
            child: Align(
                alignment: Alignment.topLeft,
                child: _captureControlRowTopWidget(),
            ),
          ),
          padding: EdgeInsets.only(top: 20, left: 15, right: 30),
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
                MaterialPageRoute(builder: (context) => InfoPost(widget.cameras)));
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
            size: 36,
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
