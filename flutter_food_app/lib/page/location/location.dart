import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'list_city.dart';
import 'package:flutter_food_app/const/color_const.dart';

class LocationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LocationPageState();
}

class LocationPageState extends State<LocationPage>{
  List<String> nameCities;
  List<List<String>> nameProvinces;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BottomBarBloc>(context)
        .changeVisible(true);
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
          "Khu vực",
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
                  BlocProvider.of<LocationBloc>(context).changeLocation(
                    BlocProvider.of<LocationBloc>(context)
                        .currentState
                        .indexCity,
                    BlocProvider.of<LocationBloc>(context)
                        .currentState
                        .indexProvince,
                  );
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: colorBackground,
        child: MaterialApp(
          home: ListCity(),
          theme: ThemeData(
            fontFamily: 'Montserrat',
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
