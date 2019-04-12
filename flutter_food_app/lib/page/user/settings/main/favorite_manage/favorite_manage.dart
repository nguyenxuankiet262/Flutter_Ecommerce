import 'package:flutter/material.dart';
import 'category.dart';
import 'package:flutter_food_app/const/color_const.dart';

List<String> nameList = [
  'Lọc',
  'Xóa tất cả',
];

class FavoriteManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavoriteManageState();
}

class FavoriteManageState extends State<FavoriteManage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(111.0), // here the desired height
        child: Column(
          children: <Widget>[
            AppBar(
              brightness: Brightness.light,
              title: new Text(
                "Bài viết yêu thích",
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
            ),
            Container(
                height: 55.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: colorInactive.withOpacity(0.2), width: 0.5))
                ),
                padding:
                EdgeInsets.only(right: 16.0, left: 16.0, bottom: 14.0),
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
                            "Tìm kiếm bài viết",
                            style: TextStyle(
                                fontSize: 14,
                                color: colorInactive,
                                fontFamily: "Ralway"),
                          )
                        ],
                      )),
                )),
          ],
        ),
      ),
      body: new CategoryRadio(),
    );
  }
}

