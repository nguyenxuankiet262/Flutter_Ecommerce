import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'category.dart';
import 'package:flutter_food_app/const/color_const.dart';

class FilterManagement extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => FilterManagementState();
}

class FilterManagementState extends State<FilterManagement>{
  DetailPageBloc detailPageBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BottomBarBloc>(context)
        .changeVisible(false);
    detailPageBloc = BlocProvider.of<DetailPageBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
              onTap: () {
                BlocProvider.of<BottomBarBloc>(context)
                    .changeVisible(true);
                Navigator.pop(context);
              },
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
                    detailPageBloc
                        .currentState
                        .tempCategory,
                    detailPageBloc
                        .currentState
                        .tempChildCategory,
                  );
                  BlocProvider.of<FunctionBloc>(context).currentState.isLoading();
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
    );
  }
}
