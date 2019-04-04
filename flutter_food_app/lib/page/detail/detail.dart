import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/page/detail/menu.dart';
import 'package:flutter_food_app/page/filter/filter.dart';

class ListAllPost extends StatefulWidget {
  Function navigateToPost, navigateToFilter, navigateToSearch;
  int index;

  ListAllPost(this.navigateToPost, this.navigateToFilter, this.navigateToSearch, this.index);

  @override
  State<StatefulWidget> createState() => _ListAllPostState();
}

class _ListAllPostState extends State<ListAllPost> {
  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      elevation: 0.0,
      brightness: Brightness.light,
      title: new Text(
        listMenu[this.widget.index].name,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      leading: GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            this.widget.navigateToFilter();
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Container(
                  padding: EdgeInsets.only(
                      top: 3.0, bottom: 3.0, right: 10.0, left: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      border: Border.all(color: colorActive, width: 0.5)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 5.0),
                        child: Icon(
                          FontAwesomeIcons.filter,
                          color: colorActive,
                          size: 10,
                        ),
                      ),
                      Text(
                        "Lọc",
                        style: TextStyle(
                            color: colorActive,
                            fontSize: 12,
                            fontFamily: "Ralway"),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(111.0), // here the desired height
        child: Column(
          children: <Widget>[
            buildAppBar(context),
            GestureDetector(
              onTap: (){
                this.widget.navigateToSearch();
              },
              child: Container(
                  height: 55.0,
                  color: Colors.white,
                  padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 14.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: colorInactive.withOpacity(0.2)),
                    child: Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 14,
                              ),
                            ),
                            Text(
                              "Tìm kiếm bài viết, người đăng",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: colorInactive,
                                  fontFamily: "Ralway"),
                            )
                          ],
                        )),
                  )),
            ),
          ],
        ),
      ),
      body: HeaderDetail(this.widget.navigateToPost, this.widget.index),
    );
  }
}
