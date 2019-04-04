import 'package:flutter/material.dart';
import 'package:flutter_food_app/page/camera/camera.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class ListImage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ListImageState();
}

class ListImageState extends State<ListImage>{
  int itemCount = 10;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: Container(
            margin: EdgeInsets.only(right: 10.0),
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
                Container(
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/images/carrot.jpg',
                      fit: BoxFit.fill,
                    ),
                    borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                  ),
                  width: 100,
                  height: 100,
                ),
                index == 0 ? Positioned(
                  bottom: 0,
                  height: 25,
                  width: 100,
                  child: Container(
                    height: 10,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        "Ảnh bìa",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: "Ralway"
                        ),
                      ),
                    ),
                  ),
                ) : Container(),
                Positioned(
                  top: 0,
                  right: 0,
                  height: 25,
                  width: 25,
                  child: GestureDetector(
                    onTap: (){
                      Toast.show("Đã xóa", context);
                    },
                    child: Container(
                      height: 10,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                          child: Icon(
                            FontAwesomeIcons.times,
                            size: 12,
                            color: Colors.white,
                          )
                      ),
                    ),
                  )
                )
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
          },
        ),
    );
  }
}