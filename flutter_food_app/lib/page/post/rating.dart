import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'list_rating.dart';
import 'package:toast/toast.dart';
import 'package:flutter_food_app/page/user/info.dart';

class CommentPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommentPostState();
}

class CommentPostState extends State<CommentPost> {
  int itemCount = 5;
  double ratingValue = 5.0;
  String textInput = "";
  final myController = new TextEditingController();

  void _showRatingList(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ListRating();
        });
  }

  @override
  void initState() {
    super.initState();

    myController.addListener(_changeTextInput);
  }

  _changeTextInput() {
    setState(() {
      textInput = myController.text;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    super.dispose();
  }

  void popupRating() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  width: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Đánh giá",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: SmoothStarRating(
                            allowHalfRating: false,
                            rating: ratingValue,
                            starCount: 5,
                            size: 30,
                            color: Colors.yellow,
                            borderColor: Colors.yellow,
                            onRatingChanged: (v) {
                              setState(() {
                                ratingValue = v;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextField(
                          controller: myController,
                          maxLengthEnforced: true,
                          maxLength: 100,
                          decoration: InputDecoration(
                            hintText: "Nhập bình luận",
                            border: InputBorder.none,
                          ),
                          cursorColor: colorActive,
                          maxLines: 4,
                        ),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: colorActive,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32.0),
                                bottomRight: Radius.circular(32.0)),
                          ),
                          child: Text(
                            "ĐỒNG Ý",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          if (textInput.isEmpty) {
                            Toast.show('Vui lòng nhập nội dung!', context,
                                duration: 2);
                          } else {
                            Toast.show('Cảm ơn bạn đã đánh giá!', context,
                                duration: 2);
                            myController.clear();
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  void navigateToUserPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InfoPage(true)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthRating = size.width - 90;
    final widthComment = size.width - 100;
    // TODO: implement build
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.0),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'ĐÁNH GIÁ',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            itemCount: itemCount,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            navigateToUserPage();
                          },
                        ),
                        Container(
                          width: widthRating,
                          margin: EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Text(
                                      index % 2 == 0
                                          ? 'Trần Văn Mèo'
                                          : 'Nguyễn Thị Cún',
                                      style: TextStyle(
                                          color: colorActive,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12
                                      ),
                                    ),
                                    onTap: (){
                                      navigateToUserPage();
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.more_vert,
                                      color: colorInactive,
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
                    index != itemCount - 1
                        ? Container(
                            margin: EdgeInsets.only(top: 16.0, right: 16.0),
                            height: 0.5,
                            width: double.infinity,
                            color: colorInactive,
                          )
                        : Container(),
                  ],
                )),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 50, bottom: 10.0, top: 5.0),
              child: Text(
                'Xem tất cả',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            onTap: () {
              _showRatingList(context);
            },
          ),
          Container(
            height: 0.5,
            color: colorInactive,
          ),
          GestureDetector(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                width: widthComment,
                height: 40,
                decoration: BoxDecoration(
                    color: colorActive,
                    border: Border.all(color: colorComment),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Center(
                  child: Text(
                    'Đánh giá',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
            onTap: () {
              popupRating();
            },
          ),
        ],
      ),
    );
  }
}
