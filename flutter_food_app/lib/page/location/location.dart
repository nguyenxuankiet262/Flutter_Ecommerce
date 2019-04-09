import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Container(
        color: colorBackground,
        child: ListCity(),
      ),
    );
  }
}
