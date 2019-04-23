import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/favorite_manage_bloc.dart';
import 'package:flutter_food_app/common/state/favorite_manage_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChildCategory extends StatefulWidget {
  final int _index;
  ChildCategory(this._index);

  @override
  State<StatefulWidget> createState() => ChildCategoryState();
}

class ChildCategoryState extends State<ChildCategory> {
  FavoriteManageBloc favoriteManageBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoriteManageBloc = BlocProvider.of<FavoriteManageBloc>(context);
    favoriteManageBloc.changeTempCategory(favoriteManageBloc.currentState.indexCategory, favoriteManageBloc.currentState.tempChildCategory);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: favoriteManageBloc,
      builder: (context, FavoriteManageState state){
        return Scaffold(
          primary: false,
          appBar: PreferredSize(
            child: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 1.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: 36,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      listMenu[widget._index].name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            preferredSize: Size(0.0, 54.0),
          ),
          body: Container(
            color: colorBackground,
            child: ListView.builder(
              itemCount: listMenu[widget._index].childMenu.length,
              itemBuilder: (BuildContext context, int index) {
                return new InkWell(
                  //highlightColor: Colors.red,
                  splashColor: colorActive,
                  onTap: () {
                    favoriteManageBloc.changeTempCategory(widget._index, index);
                  },
                  child: new CategoryItem(
                      widget._index == state.tempCategory && index == state.tempChildCategory
                          ? true
                          : false,
                      listMenu[widget._index].childMenu[index].name),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final bool _isSelected;
  final String _text;

  CategoryItem(this._isSelected, this._text);

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
          new Container(
              margin: new EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    _text,
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
              )),
          new Container(
            height: 24.0,
            width: 24.0,
            child: new Center(
              child: _isSelected
                  ? Icon(
                FontAwesomeIcons.solidDotCircle,
                size: 20,
                color: colorActive,
              )
                  : Icon(
                FontAwesomeIcons.solidCircle,
                size: 20,
                color: colorInactive.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
