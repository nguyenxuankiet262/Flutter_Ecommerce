import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/camera_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_camera_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'info/info.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:custom_multi_image_picker/custom_multi_image_picker.dart';

class CameraPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CameraPageState();
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class CameraPageState extends State<CameraPage> {
  CameraController controller;
  bool isNext = false;
  bool isRearCamera = true;
  String imagePath = "";
  List<Asset> images = List<Asset>();
  DetailCameraBloc blocProvider;

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  _onSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          ),
    );
    new Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context); //pop dialog
      new Future.delayed(new Duration(seconds: 1), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoPost()));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    blocProvider = BlocProvider.of<DetailCameraBloc>(context);
    controller = CameraController(
        BlocProvider.of<CameraBloc>(context).currentState.cameras[0],
        ResolutionPreset.high);
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

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
      );
    } on PlatformException catch (e) {
      print(e.message);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
    if (images.length > 0) {
      _onSuccess();
      List<String> temp = blocProvider.currentState.imagePaths;
      for (int i = 0; i < images.length; i++) {
        temp.add(images[i].filePath);
      }
      blocProvider.changeImageList(temp);
    }
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
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      )
                    ),
                    imagePath.isEmpty || !isNext
                        ? Center(
                        child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: CameraPreview(controller),
                        ))
                        : Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(imagePath)),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
                flex: 8,
              ),
              Expanded(
                flex: 1,
                child: Container(
                    child: Center(
                  child: _captureControlRowBottomWidget(),
                )),
              ),
            ],
          );
  }

  Widget _captureControlRowTopWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        isNext
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isNext = false;
                    imagePath = "";
                  });
                },
                child: Text(
                  'Hủy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: "Ralway",
                    decoration: TextDecoration.none,
                  ),
                ),
              )
            : GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 24,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
        GestureDetector(
          child: Text(
            'Tiếp tục',
            style: TextStyle(
              color: isNext ? Colors.white : Colors.white30,
              fontSize: 17,
              fontFamily: "Ralway",
              decoration: TextDecoration.none,
            ),
          ),
          onTap: () {
            if (isNext) {
              List<String> temp = blocProvider.currentState.imagePaths;
              temp.add(imagePath);
              blocProvider.changeImageList(temp);
              imagePath = "";
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => InfoPost()));
            }
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
          onTap: loadAssets,
        ),
        GestureDetector(
            child: Icon(
              Icons.camera,
              color: Colors.white,
              size: 50,
            ),
            onTap: onTakePictureButtonPressed),
        GestureDetector(
            child: Icon(
              Icons.cached,
              color: Colors.white,
              size: 24,
            ),
            onTap: onNewCameraSelected)
      ],
    );
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) {
          setState(() {
            isNext = true;
          });
        }
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
  }

  void onNewCameraSelected() async {
    if (controller != null) {
      await controller.dispose();
    }
    if (isRearCamera) {
      controller = CameraController(
          BlocProvider.of<CameraBloc>(context).currentState.cameras[1],
          ResolutionPreset.high);
      setState(() {
        isRearCamera = false;
      });
    } else {
      controller = CameraController(
          BlocProvider.of<CameraBloc>(context).currentState.cameras[0],
          ResolutionPreset.high);
      setState(() {
        isRearCamera = true;
      });
    }

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }
}
