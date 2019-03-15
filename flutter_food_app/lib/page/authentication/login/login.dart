import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Add box decoration
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.white,
              Colors.green[200],
              Colors.green[400],
              Colors.green[600],
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0, bottom: 10.0, right: 20.0, left: 20.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: colorFB,
                borderRadius: BorderRadius.all(Radius.circular(100.0))
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 2.0),
                    child: Center(
                      child: Text(
                        "Đăng nhập bằng Facebook",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Ralway"
                        ),
                        textAlign: TextAlign.center ,
                      )
                    )
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    width: 100,
                    height: 1,
                    color: Colors.white,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Ralway",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    width: 100,
                    height: 1,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}