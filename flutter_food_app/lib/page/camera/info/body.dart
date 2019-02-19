import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'detail/category.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

var controller = new MaskedTextController(mask: '000.000.000');

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

  void _showDialog() {
    showDialog(
        barrierDismissible: false,
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
                    "Giá tiền",
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
                      controller: controller,
                      maxLength: 11,
                      maxLengthEnforced: true,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: false),
                      decoration: InputDecoration(
                        counterStyle: TextStyle(fontSize: 0),
                        hintText: "Nhập giá",
                        suffixText: 'VNĐ',
                        suffixStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.attach_money,
                          color: colorInactive,
                        ),
                      ),
                      cursorColor: colorActive,
                      maxLines: 1,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
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
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthAddress = size.width - 200;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Theme(
          data: new ThemeData(
            primaryColor: textInput.isEmpty ? Colors.redAccent : colorActive,
            primaryColorDark: textInput.isEmpty ? Colors.red : Colors.green,
          ),
          child: new Container(
            decoration: BoxDecoration(color: Colors.white),
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
            style: TextStyle(fontSize: 13),
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryRadio()),
            );
          },
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
                            style:
                                TextStyle(color: colorInactive, fontSize: 17),
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
            onTap: () {
              _showDialog();
            }),
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
                    'Số điện thoại',
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
                          '+84 123 456 789',
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
      ],
    );
  }
}
