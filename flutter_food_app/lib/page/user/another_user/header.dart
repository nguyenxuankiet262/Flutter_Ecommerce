import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Header extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderState();
}

class HeaderState extends State<Header> {
  bool followed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthColumn = (size.width - 70) / 3;
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                color: Colors.transparent.withOpacity(0.7),
              ),
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0))),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/dog.jpg',
                            fit: BoxFit.cover,
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Lò Thị Chó',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          SmoothStarRating(
                            starCount: 5,
                            size: 15.0,
                            rating: 5,
                            color: Colors.yellow,
                            borderColor: Colors.yellow,
                          ),
                          Text(
                            '5.0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: colorInactive.withOpacity(0.5)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      width: widthColumn,
                      child: Column(
                        children: <Widget>[
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'bài viết',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colorText,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: widthColumn,
                      child: Column(
                        children: <Widget>[
                          Text(
                            '123,321',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'người theo dõi',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: colorText),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: widthColumn,
                      child: Column(
                        children: <Widget>[
                          Text(
                            '1',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'đang theo dõi',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: colorText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10.0),
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: followed == false ? colorActive : Colors.red,
                            border: Border.all(
                                color: followed == false
                                    ? colorInactive
                                    : Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: Center(
                          child: Text(
                            followed == false ? 'Theo dõi' : 'Bỏ theo dõi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          followed = !followed;
                        });
                      },
                    ),
                    flex: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 10.0, left: 2.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: followed == false ? colorActive : Colors.red,
                          border: Border.all(
                              color: followed == false
                                  ? colorInactive
                                  : Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Center(
                          child: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          padding:
              EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
          child: Text(
            "Gâu gâu!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ],
    ));
  }
}
