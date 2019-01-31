import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';

class HeaderHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HeaderHomeState();

}

class HeaderHomeState extends State<HeaderHome>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            width: 90.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
              borderRadius:
              BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      child: Image.asset(
                        'assets/images/salad.jpg',
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(
                          Radius.circular(5.0))),
                  width: 130,
                  height: 100,
                ),
                Center(
                    child: Text(
                      'Rau củ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            width: 90.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
              borderRadius:
              BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      child: Image.asset(
                        'assets/images/fruit.jpg',
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(
                          Radius.circular(5.0))),
                  width: 130,
                  height: 100,
                ),
                Center(
                    child: Text(
                      'Trái cây',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            width: 90.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
              borderRadius:
              BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      child: Image.asset(
                        'assets/images/meat.jpg',
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(
                          Radius.circular(5.0))),
                  width: 130,
                  height: 100,
                ),
                Center(
                    child: Text(
                      'Thịt',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            width: 90.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
              borderRadius:
              BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      child: Image.asset(
                        'assets/images/fish.jpg',
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(
                          Radius.circular(5.0))),
                  width: 130,
                  height: 100,
                ),
                Center(
                    child: Text(
                      'Cá',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            width: 90.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
              borderRadius:
              BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      child: Image.asset(
                        'assets/images/hamburger.jpg',
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(
                          Radius.circular(5.0))),
                  width: 130,
                  height: 100,
                ),
                Center(
                    child: Text(
                      'Đồ ăn',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            width: 90.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
              borderRadius:
              BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      child: Image.asset(
                        'assets/images/cake.jpg',
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(
                          Radius.circular(5.0))),
                  width: 130,
                  height: 100,
                ),
                Center(
                    child: Text(
                      'Bánh ngọt',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            width: 90.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
              borderRadius:
              BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      child: Image.asset(
                        'assets/images/other.jpg',
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(
                          Radius.circular(5.0))),
                  width: 130,
                  height: 100,
                ),
                Center(
                    child: Text(
                      'Khác',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ],
      ),
      height: 70,
    );
  }

}