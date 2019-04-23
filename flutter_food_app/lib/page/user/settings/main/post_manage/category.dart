import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/model/category.dart';

class CategoryRadio extends StatefulWidget {
  @override
  createState() {
    return new CategoryRadioState();
  }
}

class CategoryRadioState extends State<CategoryRadio> {
  List<CategoryModel> categories = new List<CategoryModel>();
  bool isCategory = true;
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < listMenu.length; i++) {
      categories.add(new CategoryModel(listMenu[i].image, listMenu[i].name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: false,
        appBar:
            PreferredSize(child: Container(), preferredSize: Size(0.0, 0.0)),
        body: Stack(children: <Widget>[
          Container(
            color: Colors.transparent,
            child: new ListView.builder(
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return new InkWell(
                  //highlightColor: Colors.red,
                  splashColor: colorActive,
                  onTap: () {
                    setState(() {
                      _index = index;
                      isCategory = false;
                    });
                  },

                  child: new CategeoryItem(categories[index]),
                );
              },
            ),
          ),
        ])
    );
  }
}

class CategeoryItem extends StatelessWidget {
  final CategoryModel _item;

  CategeoryItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  color: colorInactive.withOpacity(0.2), width: 0.5))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                new Container(
                  height: 50.0,
                  width: 50.0,
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
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: new Text(
                            '10 bài viết',
                            style: TextStyle(
                                color: colorInactive,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ))
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
