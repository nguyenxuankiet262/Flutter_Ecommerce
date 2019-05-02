import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/filter/location.dart';
import 'package:flutter_food_app/page/filter/price.dart';
import 'package:flutter_food_app/page/filter/rating.dart';
import 'package:flutter_food_app/page/filter/sort.dart';

class FilterPage extends StatefulWidget{
  //_index = 1: full options
  //_index = 2: remove location sort and price sort
  //_index = 3: only rating sort
  final int _index;
  FilterPage(this._index);
  @override
  State<StatefulWidget> createState() => FilterPageState();
}

class FilterPageState extends State<FilterPage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BottomBarBloc>(context)
        .changeVisible(false);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        brightness: Brightness.light,
        title: new Text(
          "Lọc",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: <Widget>[
          new Center(
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: GestureDetector(
                child: Text(
                  'ĐẶT LẠI',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: colorActive,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                onTap: () {
                },
              ),
            ),
          ),
        ],
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            BlocProvider.of<BottomBarBloc>(context)
                .changeVisible(true);
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            widget._index == 2 || widget._index == 3 ? Container() : PriceFilter(),
            widget._index == 2 || widget._index == 3 ? Container() : LocationFilter(),
            Container(
              padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0, top: 16.0),
              child: Text(
                "ĐÁNH GIÁ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 30,
              margin: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
              child: RatingFilter(),
            ),
            widget._index == 3 ? Container () : SortContent(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        child: RaisedButton(
          onPressed: (){
            BlocProvider.of<BottomBarBloc>(context)
                .changeVisible(true);
            Navigator.pop(context);
          },
          color: colorActive,
          child: Center(
            child: Text(
              'ÁP DỤNG',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12.0),
            ),
          ),
        )
      ),
    );
  }
}