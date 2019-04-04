import 'package:flutter/material.dart';
import 'package:flutter_food_app/common/bloc/camera_bloc.dart';
import 'splash.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final cameraBloc = CameraBloc();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<CameraBloc>(bloc: cameraBloc),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          canvasColor: Colors.transparent,
        ),
        debugShowCheckedModeBanner: false,
        home: StartPage(cameras),
      )
    );
  }
}
