import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_food_app/page/user/info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListRating extends StatefulWidget {
  int index;

  ListRating(this.index);

  @override
  State<StatefulWidget> createState() => ListRatingState();
}

class ListRatingState extends State<ListRating> {
  int itemCount;
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    if (widget.index == 0 || widget.index == 2 || widget.index == 3) {
      itemCount = 10;
    } else if (widget.index == 1) {
      itemCount = 2;
    } else {
      itemCount = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthRating = size.width - 96;
    return isLoading
        ? Container(
            height: MediaQuery.of(context).size.height / 2,
            color: colorBackground,
            child: Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(colorActive),
            )))
        : Container(
            color: colorBackground,
            child: itemCount == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage("assets/images/icon_heartbreak.png"),
                          ),
                        ),
                        height: 200,
                        width: 200,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Text('Chưa có bài viết!'),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: itemCount,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 0),
                    itemBuilder: (BuildContext context, int index) => Card(
                          child: Container(
                              padding: EdgeInsets.all(16.0),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        child: ClipOval(
                                          child: Image.asset(
                                            index % 2 == 0
                                                ? 'assets/images/cat.jpg'
                                                : 'assets/images/dog.jpg',
                                            fit: BoxFit.cover,
                                            width: 40.0,
                                            height: 40.0,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InfoPage(true)),
                                          );
                                        },
                                      ),
                                      Container(
                                        width: widthRating,
                                        margin: EdgeInsets.only(left: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  index % 2 == 0
                                                      ? 'Trần Văn Mèo'
                                                      : 'Nguyễn Thị Cún',
                                                  style: TextStyle(
                                                    color: colorActive,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Icon(
                                                    FontAwesomeIcons
                                                        .solidEyeSlash,
                                                    size: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 4.0),
                                              child: SmoothStarRating(
                                                starCount: index % 2 == 0 ? 5 : 4,
                                                size: 16.0,
                                                rating: 5,
                                                color: Colors.yellow,
                                                borderColor: Colors.yellow,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Text(
                                                index % 2 == 0
                                                    ? 'Ngon bổ rẻ'
                                                    : "Likeeeeeeeeeee!!!!!!!!!!!!!!!!!!! Ủng hộ shop !! Yêu shop !!!!!!!!!!",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Text(
                                              '22:22 PM - 22/2/2022',
                                              style: TextStyle(
                                                  color: colorInactive,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 10),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        )),
          );
  }
}
