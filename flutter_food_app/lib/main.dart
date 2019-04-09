import 'package:flutter/material.dart';
import 'package:flutter_food_app/common/bloc/camera_bloc.dart';
import 'package:flutter_food_app/common/bloc/grid_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'splash.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final gridBloc = GridBloc();
  final cameraBloc = CameraBloc();
  final locationBloc = LocationBloc();
  final searchBloc = SearchBloc();
  // This widget is the root of your application.

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    gridBloc.dispose();
    cameraBloc.dispose();
    locationBloc.dispose();
    searchBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<GridBloc>(bloc: gridBloc),
        BlocProvider<CameraBloc>(bloc: cameraBloc),
        BlocProvider<LocationBloc>(bloc: locationBloc),
        BlocProvider<SearchBloc>(bloc: searchBloc),
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
