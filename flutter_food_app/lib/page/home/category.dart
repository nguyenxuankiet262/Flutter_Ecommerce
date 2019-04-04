import "package:flutter/material.dart";
import 'list_post.dart';
import 'package:flutter_food_app/model/menu.dart';

class ListCategory extends StatefulWidget {
  Function navigateToPost;

  ListCategory(this.navigateToPost);

  @override
  State<StatefulWidget> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {

  List<Menu> listMenu = [
    Menu("Giảm nhiều nhất", 'assets/images/discount.jpg', [

    ]),
    Menu('Yêu thích nhất', 'assets/images/favorite.png', [

    ]),
  ];

  void _gotoPostScreen() {
    this.widget.navigateToPost();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          new Container(
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
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
                      listMenu[index].name.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    )
                  ],
                ),
              ],
            ),
          ),
          ListPost(this._gotoPostScreen),
        ],
      ),
    );
  }
}