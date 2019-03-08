import 'package:flutter/material.dart';
import 'slider.dart';
import 'body.dart';
import 'rating.dart';
import 'relative_post.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:toast/toast.dart';
import 'package:rounded_modal/rounded_modal.dart';

List<Icon> iconList = [
  Icon(
    Icons.share,
    color: Colors.blue,
  ),
  Icon(
    Icons.star,
    color: Colors.yellow,
  ),
  Icon(
    Icons.block,
    color: Colors.red,
  ),
  Icon(
    Icons.favorite,
    color: Colors.pink,
  ),
];

List<String> nameList = [
  'Chia sẻ',
  'Lưu vào bookmark',
  'Báo cáo vi phạm',
  'Yêu thích',
];

class Post extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostState();
}

class PostState extends State<Post> {
  String textInput = "";
  final myController = new TextEditingController();

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

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Báo cáo",
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
                        color: Colors.red,
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
                            gravity: Toast.CENTER);
                      } else {
                        myController.clear();
                        Navigator.pop(context);
                        Toast.show('Cảm ơn bạn đã báo cáo!', context,
                            gravity: Toast.CENTER);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showSettingSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 220.0,
            color: Colors.white, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 2,
                        color: colorInactive,
                      ),
                    )),
                ListView.builder(
                  itemCount: iconList.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: colorInactive, width: 0.2))),
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              iconList[index],
                              Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  nameList[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          switch (index) {
                            case 0:
                              {
                                Toast.show('Share', context,
                                    gravity: Toast.CENTER);
                                Navigator.pop(context);
                              }
                              break;
                            case 1:
                              {
                                Toast.show('Đã lưu vào bookmark', context,
                                    gravity: Toast.CENTER);
                                Navigator.pop(context);
                              }
                              break;
                            case 2:
                              {
                                _showDialog();
                              }
                              break;
                            case 3:
                              {
                                Navigator.pop(context);
                              }
                          }
                        },
                      ),
                ),
              ],
            ),
          );
        });
  }

  _showCart(){
    showModalBottomSheet(
      context: context, // Also default
      builder: (context) => Container(
        color: Colors.transparent,
        height: 500,
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Container(
                    width: 50,
                    height: 2,
                    color: Colors.white,
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 150,
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/flan.jpg'),
                            )
                        ),
                      ),
                      Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 220,
                                child: Text(
                                  'Bánh tiramisu thơm ngon đây cả nhà ơi',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),

                              Text(
                                  '500.000 VNĐ'
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text(
            'Bánh tiramisu thơm ngon đây cả nhà ơi',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              tooltip: 'Tùy chỉnh',
              onPressed: () {
                _showSettingSheet();
              },
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              CarouselWithIndicator(),
              PostBody(),
              CommentPost(),
              RelativePost(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: colorActive, width: 1.5)
                  ),
                  child: GestureDetector(
                    onTap: (){
                      _showCart();
                    },
                    child: Center(
                      child: Text(
                        'THÊM VÀO GIỎ HÀNG',
                        style: TextStyle(color: colorActive, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  color: colorActive,
                  child: Center(
                    child: Text(
                      'GỌI ĐIỆN NGƯỜI BÁN',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                flex: 1,
              ),

            ],
          ),
        ),
    );
  }
}
