import 'package:flutter/material.dart';
import 'package:flutter_food_app/page/camera/camera.dart';
import 'list_image.dart';

class HeaderInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderInfoState();
}

class HeaderInfoState extends State<HeaderInfo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                width: 100,
                height: 90,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Future.delayed(new Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CameraPage()),
                  );
                });
              }),
          ListImage()
        ],
      ),
    );
  }
}
