import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/model/child_category.dart';
import 'detail_category.dart';

class ChildCategory extends StatefulWidget {
  String title;
  int index;

  ChildCategory(this.title, this.index);

  @override
  createState() {
    return new ChildCategoryState();
  }
}

class ChildCategoryState extends State<ChildCategory> {
  List<RadioModel> categories = new List<RadioModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 1; i < listMenu[widget.index].childMenu.length; i++) {
      categories.add(new RadioModel(
          i == 1 ? true : false,
          listMenu[widget.index].childMenu[i].image,
          listMenu[widget.index].childMenu[i].name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(111.0), // here the desired height
          child: Column(
            children: <Widget>[
              AppBar(
                brightness: Brightness.light,
                title: new Text(
                  widget.title,
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
        body: Container(
          color: colorBackground,
          child: new ListView.builder(
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return new InkWell(
                //highlightColor: Colors.red,
                splashColor: colorActive,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailCategory(categories[index].text, index)),
                  );
                },

                child: new RadioItem(categories[index], index),
              );
            },
          ),
        ));
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  int index;

  RadioItem(this._item, this.index);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  color: colorInactive.withOpacity(0.2), width: 0.5
          ))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                new Container(
                  height: 80.0,
                  width: 80.0,
                  child: ClipRRect(
                      child: Image.asset(
                        _item.image,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0))),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: colorInactive),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                new Container(
                    margin: new EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          _item.text,
                          style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: new Text(
                            '10 bài viết',
                            style: TextStyle(color: colorInactive, fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          ),
          new Container(
            height: 24.0,
            width: 24.0,
            child: new Center(
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
