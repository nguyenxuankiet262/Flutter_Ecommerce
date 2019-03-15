import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
import 'list_post.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class ListCategory extends StatefulWidget {
  Function callback1, callback2, callback3;

  ListCategory(this.callback1, this.callback2, this.callback3);

  @override
  State<StatefulWidget> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = new List<Widget>();
    int i = 0;
    slivers.addAll(_buildLists(context, i, i += nameCategory.length));
    return slivers;
  }

  List<String> nameCategory = [
    'Ưu đãi',
    'Nổi bật',
  ];

  void _gotoDetailScreen() {
    this.widget.callback1();
  }

  void _gotoPostScreen() {
    this.widget.callback2();
  }

  void _gotoUserScreen() {
    this.widget.callback3();
  }

  List<Widget> _buildLists(BuildContext context, int firstIndex, int count) {
    return List.generate(count, (sliverIndex) {
      sliverIndex += firstIndex;
      return new SliverStickyHeader(
        header: _buildHeader(sliverIndex),
        sliver: new SliverToBoxAdapter(
          child: ListPost(this._gotoPostScreen, this._gotoUserScreen),
        ),
      );
    });
  }

  Widget _buildHeader(int index, {String text}) {
    return new Container(
      height: 60.0,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5.0),
                child: index == 0
                    ? Image.asset('assets/images/discount_icon.png')
                    : new Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              Text(
                text ?? nameCategory[index].toUpperCase(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              )
            ],
          ),
          GestureDetector(
            child: new Text(
              'Tất cả',
              style: TextStyle(
                  color: colorActive,
                  decoration: TextDecoration.underline,
                  fontSize: 17.0),
            ),
            onTap: () {
              _gotoDetailScreen();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SimpleScaffold(
      child: new Builder(builder: (BuildContext context) {
        return new CustomScrollView(
          slivers: _buildSlivers(context),
        );
      }),
    );
  }
}

class SimpleScaffold extends StatelessWidget {
  const SimpleScaffold({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: child,
    );
  }
}
