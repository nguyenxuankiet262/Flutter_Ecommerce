import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';

class BodyInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BodyInfoState();
}

class BodyInfoState extends State<BodyInfo> {
  String textInput = "";
  final myController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_changeTextInput);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    super.dispose();
  }

  _changeTextInput() {
    setState(() {
      textInput = myController.text;
      print(textInput);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final widthAddress = size.width - 200;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Theme(
          data: new ThemeData(
            primaryColor:
            textInput.isEmpty ? Colors.redAccent : colorActive,
            primaryColorDark: textInput.isEmpty ? Colors.red : Colors.green,
          ),
          child: new Container(
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: new TextField(
              cursorColor: colorActive,
              controller: myController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: colorInactive)),
                hintText: 'Nhập nội dung bài viết',
              ),
              autofocus: false,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: Text(
            'Nội dung càng rõ ràng, càng nhiều người quan tâm!',
            style: TextStyle(
              fontSize: 13
            ),
          ),
        ),

        GestureDetector(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: colorInactive))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Lựa chọn danh mục',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Rau củ',
                          style: TextStyle(color: colorInactive, fontSize: 17),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: Colors.black,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: colorInactive))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Thêm giá',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text(
                          '100.000 VNĐ',
                          style: TextStyle(color: colorInactive, fontSize: 17),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: Colors.black,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: colorInactive))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Thêm địa điểm',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: widthAddress,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            '123 Đường lên đỉnh Olympia F.15 Q.TB, TP.HCM',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                            TextStyle(color: colorInactive, fontSize: 17),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: Colors.black,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
