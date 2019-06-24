import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/page/filter/detail/category.dart';
import 'package:flutter_food_app/const/color_const.dart';

class FilterDetailManagement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FilterDetailManagementState();
}

class FilterDetailManagementState extends State<FilterDetailManagement> {
  DetailPageBloc detailPageBloc;
  ApiBloc apiBloc;
  LoadingBloc loadingBloc;
  FunctionBloc functionBloc;
  LocationBloc locationBloc;
  String address = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    if(locationBloc.currentState.indexCity != 0){
      if(locationBloc.currentState.indexProvince != 0){
        address = locationBloc.currentState.nameProvinces
        [locationBloc.currentState.indexCity]
        [locationBloc.currentState.indexProvince]
            + ", "
            + locationBloc.currentState.nameCities
            [locationBloc.currentState.indexCity];
      }
      else{
        address = locationBloc.currentState.nameCities
        [locationBloc.currentState.indexCity];
      }
    }
    detailPageBloc = BlocProvider.of<DetailPageBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
  }

  Future<bool> _onBackPressed() {
    Navigator.pop(context);
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.5,
            brightness: Brightness.light,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              "Danh mục",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: new Center(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: GestureDetector(
                  child: Text(
                    'HỦY',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  onTap: _onBackPressed,
                ),
              ),
            ),
            actions: <Widget>[
              new Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    child: Text(
                      'ÁP DỤNG',
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: colorActive,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    onTap: () {
                      detailPageBloc.changeCategory(
                        detailPageBloc.currentState.tempCategory,
                        detailPageBloc.currentState.tempChildCategory,
                      );
                      functionBloc.currentState.isLoading();
                      loadingBloc.changeLoadingDetail(true);
                      if (detailPageBloc.currentState.tempChildCategory == 0) {
                        functionBloc.currentState.onFetchProductMenu(
                            apiBloc
                                .currentState
                                .listMenu[
                                    detailPageBloc.currentState.tempCategory]
                                .id,
                            detailPageBloc.currentState.code.toString(),
                            detailPageBloc.currentState.min.toString(),
                            detailPageBloc.currentState.max.toString(),
                            "1",
                            "10",
                            address);
                      } else {
                        functionBloc.currentState.onFetchProductChildMenu(
                            apiBloc
                                .currentState
                                .listMenu[
                                    detailPageBloc.currentState.tempCategory]
                                .listChildMenu[detailPageBloc
                                    .currentState.tempChildCategory]
                                .id,
                            detailPageBloc.currentState.code.toString(),
                            detailPageBloc.currentState.min.toString(),
                            detailPageBloc.currentState.max.toString(),
                            "1",
                            "10",
                            address);
                      }

                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            color: colorBackground,
            child: MaterialApp(
              home: CategoryRadio(),
              theme: ThemeData(
                fontFamily: 'Montserrat',
              ),
              debugShowCheckedModeBanner: false,
            ),
          ),
        ));
  }
}
