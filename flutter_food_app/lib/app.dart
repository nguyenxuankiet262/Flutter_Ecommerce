import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/common/bloc/camera_bloc.dart';
import 'package:flutter_food_app/common/bloc/grid_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_option_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/model/menu.dart';
import 'package:flutter_food_app/page/page.dart';

class MainApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => MainAppState();
}

class MainAppState extends State<MainApp>{
  final countBloc = GridBloc();
  final locationBloc = LocationBloc();
  final locationOptionBloc = LocationOptionBloc();
  final searchBloc = SearchBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    countBloc.dispose();
    locationBloc.dispose();
    locationOptionBloc.dispose();
    searchBloc.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<GridBloc>(bloc: countBloc),
        BlocProvider<LocationBloc>(bloc: locationBloc),
        BlocProvider<LocationOptionBloc>(bloc: locationOptionBloc),
        BlocProvider<SearchBloc>(bloc: searchBloc),
      ],
      child: MyMainPage(),
    );
  }
}