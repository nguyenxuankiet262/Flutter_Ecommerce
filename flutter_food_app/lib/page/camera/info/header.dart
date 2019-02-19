import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/camera/camera.dart';
import 'package:camera/camera.dart';

class HeaderInfo extends StatefulWidget {
  List<CameraDescription> cameras;

  HeaderInfo(this.cameras);

  @override
  State<StatefulWidget> createState() => HeaderInfoState();
}

class HeaderInfoState extends State<HeaderInfo> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _widthImage = (size.width - 80) / 4;
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          child: Container(
            width: _widthImage,
            height: _widthImage,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
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
                Container(
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/images/carrot.jpg',
                      fit: BoxFit.fill,
                    ),
                    borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0)),
                  ),
                  height: _widthImage,
                  width: _widthImage,
                ),
              ],
            ),
          ),
          onTap: () {
            Future.delayed(new Duration(seconds: 1), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CameraPage(widget.cameras)),
              );
            });
          },
        ),
        GestureDetector(
            child: Container(
              width: _widthImage,
              height: _widthImage,
              decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border.all(color: colorInactive),
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
                      builder: (context) => CameraPage(widget.cameras)),
                );
              });
            }),
        GestureDetector(
          child: Container(
            width: _widthImage,
            height: _widthImage,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
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
                    builder: (context) => CameraPage(widget.cameras)),
              );
            });
          },
        ),
        GestureDetector(
          child: Container(
            width: _widthImage,
            height: _widthImage,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
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
                    builder: (context) => CameraPage(widget.cameras)),
              );
            });
          },
        ),
      ],
    );
  }
}
