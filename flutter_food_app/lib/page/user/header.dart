import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'follow/follow.dart';
import 'package:avatar_glow/avatar_glow.dart';

class Header extends StatefulWidget {
  final bool isAnother;

  Header(this.isAnother);

  @override
  State<StatefulWidget> createState() => HeaderState();
}

class HeaderState extends State<Header> {
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
                      child: AvatarGlow(
                        glowColor: Colors.white.withOpacity(0.2),
                        endRadius: 90.0,
                        duration: Duration(milliseconds: 3000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 1000),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.0))),
                          child: ClipOval(
                            child: Image.asset(
                              widget.isAnother
                                  ? 'assets/images/dog.jpg'
                                  : 'assets/images/cat.jpg',
                              fit: BoxFit.cover,
                              width: 100.0,
                              height: 100.0,
                            ),
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
                            widget.isAnother ? 'Lò Thị Chó' : 'Trần Văn Mèo',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600),
                          ),
                          SmoothStarRating(
                            starCount: 5,
                            size: 20.0,
                            rating: 4,
                            color: Colors.yellow,
                            borderColor: Colors.yellow,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  width: widthColumn,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '11',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'bài viết',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: colorText, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FollowPage(value: 1)),
                                  );
                                },
                                child: Container(
                                  width: widthColumn,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '15',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'người theo dõi',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: colorText, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FollowPage(value: 2)),
                                  );
                                },
                                child: Container(
                                  width: widthColumn,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '15M',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'đang theo dõi',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: colorText, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: null,
        ),
      ],
    ));
  }
}
