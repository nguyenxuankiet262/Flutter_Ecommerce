import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/address_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/model/child_category.dart';
import 'detail_category.dart';

class ChildCategory extends StatefulWidget {
  int index;

  ChildCategory(this.index);

  @override
  createState() {
    return new ChildCategoryState();
  }
}

class ChildCategoryState extends State<ChildCategory> {
  List<RadioModel> categories = new List<RadioModel>();
  bool isChild = true;
  int _index = 0;

  Future<bool> _backpress() async {
    //print("BACK_D");
    List<String> temp =
    BlocProvider.of<AddressBloc>(context).currentState.address.split("/");
    BlocProvider.of<AddressBloc>(context).changeText("/" + temp[1]);
    BlocProvider.of<AddressBloc>(context).changeIndex(1);
    setState(() {
      isChild = true;
    });
    return Future.value(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddressBloc>(context).changeIndex(1);
    BlocProvider.of<AddressBloc>(context).backpressDetail(_backpress);
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
      primary: false,
      appBar: PreferredSize(child: Container(), preferredSize: Size(0.0, 0.0)),
      body: Stack(children: <Widget>[
        Container(
          color: colorBackground,
          child: new ListView.builder(
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return new InkWell(
                //highlightColor: Colors.red,
                splashColor: colorActive,
                onTap: () {
                  BlocProvider.of<AddressBloc>(context).changeText(
                      BlocProvider.of<AddressBloc>(context)
                          .currentState
                          .address +
                          "/" +
                          categories[index].text);
                  setState(() {
                    _index = index;
                    isChild = false;
                  });
                },

                child: new RadioItem(categories[index], index),
              );
            },
          ),
        ),
        Visibility(
          maintainState: false,
          visible: isChild ? false : true,
          child: DetailCategory(_index),
        )
      ]),
    );
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
