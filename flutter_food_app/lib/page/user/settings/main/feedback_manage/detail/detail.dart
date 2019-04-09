import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'image.dart';

class DetailFeedback extends StatelessWidget {
  int _index;

  DetailFeedback(this._index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Thông tin phản hồi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Miêu tả vấn đề",
                  style: TextStyle(
                      fontFamily: "Ralway", fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                color: Colors.white,
                child: Text(
                  "Đừng nghĩ cứ học Marketing thì có nghĩa là có thể Treo đầu dê - Bán thịt chó!",
                  style: TextStyle(
                    fontFamily: "Ralway",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                child: Text(
                  "Hình ảnh",
                  style: TextStyle(
                      fontFamily: "Ralway", fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  padding:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                  color: Colors.white,
                  child: CarouselWithIndicator()),
              Container(
                padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                child: Text(
                  "Trả lời",
                  style: TextStyle(
                      fontFamily: "Ralway", fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                color: colorBackground,
                child: Text(
                  _index == 0
                      ? "Cảm ơn bạn đã ủng hộ Anzi, chúc bạn một ngày vui vẻ.\nNếu bạn thích ứng dụng thì hãy rating 5 sao nhé ! \nTks bạn"
                      : "Chưa trả lời",
                  style: TextStyle(
                    fontFamily: "Ralway",
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
