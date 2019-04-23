import 'package:flutter/material.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/camera_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_camera_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/post_manage_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
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
  final cameraBloc = CameraBloc();
  final locationBloc = LocationBloc();
  final searchBloc = SearchBloc();
  final searchInputBloc = SearchInputBloc();
  final bottomBarBloc = BottomBarBloc();
  final functionBloc = FunctionBloc();
  final detailCameraBloc = DetailCameraBloc();
  final userBloc = UserBloc();
  final postManageBloc = PostManageBloc();
  // This widget is the root of your application.

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraBloc.dispose();
    locationBloc.dispose();
    searchBloc.dispose();
    searchInputBloc.dispose();
    bottomBarBloc.dispose();
    functionBloc.dispose();
    detailCameraBloc.dispose();
    userBloc.dispose();
    postManageBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<CameraBloc>(bloc: cameraBloc),
        BlocProvider<LocationBloc>(bloc: locationBloc),
        BlocProvider<SearchBloc>(bloc: searchBloc),
        BlocProvider<SearchInputBloc>(bloc: searchInputBloc,),
        BlocProvider<BottomBarBloc>(bloc: bottomBarBloc,),
        BlocProvider<FunctionBloc>(bloc: functionBloc,),
        BlocProvider<DetailCameraBloc>(bloc: detailCameraBloc,),
        BlocProvider<UserBloc>(bloc: userBloc,),
        BlocProvider<PostManageBloc>(bloc: postManageBloc,),
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
