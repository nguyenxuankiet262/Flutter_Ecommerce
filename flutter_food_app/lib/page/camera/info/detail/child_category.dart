import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_camera_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/model/child_category.dart';

class ChildCategory extends StatefulWidget {
  final String title;
  final int index;
  ChildCategory(this.title, this.index);
  @override
  createState() => ChildCategoryState();
}

class ChildCategoryState extends State<ChildCategory> {
  List<RadioModel> categories = new List<RadioModel>();
  DetailCameraBloc blocProvider;
  ApiBloc apiBloc;
  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    blocProvider = BlocProvider.of<DetailCameraBloc>(context);
    for(int i = 1; i < apiBloc.currentState.listMenu[widget.index].listChildMenu.length; i++){
      categories.add(new RadioModel(i == 1 ? true : false, apiBloc.currentState.listMenu[widget.index].listChildMenu[i].link, apiBloc.currentState.listMenu[widget.index].listChildMenu[i].name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
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
          actions: <Widget>[
            new Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: GestureDetector(
                  child: Text(
                    'ÁP DỤNG',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                        color: colorActive,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  onTap: () {
                    blocProvider.changeIndexCategory(widget.index, _index + 1);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
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
                  setState(() {
                    categories.forEach((element) => element.isSelected = false);
                    categories[index].isSelected = true;
                    _index = index;
                  });
                },

                child: new RadioItem(categories[index]),
              );
            },
          ),
        )
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

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
                      child: Image.network(
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
              child: _item.isSelected
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
            ),
          ),
        ],
      ),
    );
  }
}