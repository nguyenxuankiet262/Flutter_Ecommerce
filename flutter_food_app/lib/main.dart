import 'package:flutter/material.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/camera_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_camera_bloc.dart';
import 'package:flutter_food_app/common/bloc/favorite_manage_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/info_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/post_manage_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/my_behavior.dart';
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
  final loadingBloc = LoadingBloc();
  final cameraBloc = CameraBloc();
  final locationBloc = LocationBloc();
  final searchBloc = SearchBloc();
  final bottomBarBloc = BottomBarBloc();
  final functionBloc = FunctionBloc();
  final detailCameraBloc = DetailCameraBloc();
  final userBloc = UserBloc();
  final postManageBloc = PostManageBloc();
  final favoriteManageBloc = FavoriteManageBloc();
  final detailPageBloc = DetailPageBloc();
  final apiBloc = ApiBloc();
  final searchInputBloc = SearchInputBloc();
  final listSearchProductBloc = ListSearchProductBloc();
  final infoBloc = InfoBloc();
  // This widget is the root of your application.

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    infoBloc.dispose();
    locationBloc.dispose();
    cameraBloc.dispose();
    locationBloc.dispose();
    searchBloc.dispose();
    bottomBarBloc.dispose();
    functionBloc.dispose();
    detailCameraBloc.dispose();
    userBloc.dispose();
    postManageBloc.dispose();
    favoriteManageBloc.dispose();
    detailPageBloc.dispose();
    apiBloc.dispose();
    searchInputBloc.dispose();
    listSearchProductBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<LoadingBloc>(bloc: loadingBloc),
        BlocProvider<CameraBloc>(bloc: cameraBloc),
        BlocProvider<LocationBloc>(bloc: locationBloc),
        BlocProvider<SearchBloc>(bloc: searchBloc),
        BlocProvider<BottomBarBloc>(bloc: bottomBarBloc,),
        BlocProvider<FunctionBloc>(bloc: functionBloc,),
        BlocProvider<DetailCameraBloc>(bloc: detailCameraBloc,),
        BlocProvider<UserBloc>(bloc: userBloc,),
        BlocProvider<PostManageBloc>(bloc: postManageBloc,),
        BlocProvider<FavoriteManageBloc>(bloc: favoriteManageBloc),
        BlocProvider<DetailPageBloc>(bloc: detailPageBloc),
        BlocProvider<SearchInputBloc>(bloc: searchInputBloc,),
        BlocProvider<ListSearchProductBloc>(bloc: listSearchProductBloc,),
        BlocProvider<ApiBloc>(bloc: apiBloc),
        BlocProvider<InfoBloc>(bloc: infoBloc),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
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
