import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'list_follow.dart';

class FollowPage extends StatefulWidget {
  final int value;

  FollowPage({Key key, this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FollowPageState();
}

class FollowPageState extends State<FollowPage> {
  bool isSearch = false;
  final myController = TextEditingController();
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focus = new FocusNode();
    _focus.addListener(() {
      if (!_focus.hasFocus && myController.text.isEmpty) {
        setState(() {
          isSearch = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          widget.value == 1 ? "Người theo dõi" : "Đang theo dõi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
                height: 40,
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: colorInactive.withOpacity(0.2)),
                child: isSearch
                    ? Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: TextField(
                          autofocus: true,
                          focusNode: _focus,
                          controller: myController,
                          style: TextStyle(fontFamily: "Ralway", fontSize: 14, color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tìm kiếm người theo dõi',
                              hintStyle: TextStyle(
                                  color: colorInactive,
                                  fontFamily: "Ralway",
                                  fontSize: 14),
                              icon: Icon(
                                Icons.search,
                                color: colorInactive,
                                size: 20,
                              )),
                        ))
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isSearch = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: colorInactive,
                              size: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: Text(
                                "Tìm kiếm",
                                style: TextStyle(
                                    fontFamily: "Raleway",
                                    color: colorInactive,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ))),
            ListFollow(),
          ],
        ),
      ),
    );
  }
}
