import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
import 'slider.dart';
import 'category.dart';
import 'header.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(128.0), // here the desired height
          child: Column(
            children: <Widget>[
              AppBar(
                brightness: Brightness.light,
                leading: Image.asset('assets/images/logo.png'),
                title: new Text(
                  'Anzi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.justify,
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                actions: [
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        child: Padding(
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.only(right: 10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              HeaderHome(),
              new Container(
                height: 1 ,
                color: Colors.black12,
              ),
            ],
          ),
      ),
      body: ListCategory(),
    );
  }
}
