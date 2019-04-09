import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/model/category.dart';
import 'child_category.dart';

class CategoryRadio extends StatefulWidget {
  @override
  createState() {
    return new CategoryRadioState();
  }
}

class CategoryRadioState extends State<CategoryRadio> {
  List<CategoryModel> categories = new List<CategoryModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0; i < listMenu.length; i++){
      categories.add(new CategoryModel(listMenu[i].image, listMenu[i].name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        brightness: Brightness.light,
        title: new Text(
          'Lựa chọn danh mục',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
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
                  MaterialPageRoute(builder: (context) => ChildCategory(listMenu[index].name, index)),
                );
              },

              child: new CategeoryItem(categories[index]),
            );
          },
        ),
      )
    );
  }
}

class CategeoryItem extends StatelessWidget {
  final CategoryModel _item;

  CategeoryItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: colorInactive,
            width: 0.5,
          ))),
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
                  child: new Text(
                      _item.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
                    ),
                  ),
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

