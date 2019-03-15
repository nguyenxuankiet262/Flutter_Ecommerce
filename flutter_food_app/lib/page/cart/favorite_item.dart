import 'package:flutter/material.dart';

class FavoriteItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavoriteItemState();
}

class FavoriteItemState extends State<FavoriteItem> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0, bottom: 2.0),
            child: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.black,
              size: 20,
            ),
          ),
          Text(
            'YÊU THÍCH',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
