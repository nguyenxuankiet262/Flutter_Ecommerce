import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
import 'post.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class ListCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  int itemCount = 10;

  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = new List<Widget>();
    int i = 0;
    slivers.addAll(_buildLists(context, i, i += nameCategory.length));
    return slivers;
  }

  List<String> nameCategory = [
    'Rau củ',
    'Trái cây',
    'Thịt',
    'Cá',
    'Đồ ăn',
    'Bánh ngọt',
    'Khác'
  ];

  List<Widget> _buildLists(BuildContext context, int firstIndex, int count) {
    return List.generate(count, (sliverIndex) {
      sliverIndex += firstIndex;
      return new SliverStickyHeader(
        header: _buildHeader(sliverIndex),
        sliver: new SliverToBoxAdapter(
          child: ListPost(),
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
          new Text(
            text ?? nameCategory[index].toUpperCase(),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          GestureDetector(
            child: new Text(
              'Tất cả',
              style: TextStyle(
                  color: colorActive,
                  decoration: TextDecoration.underline,
                  fontSize: 20.0),
            ),
            onTap: () {},
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
