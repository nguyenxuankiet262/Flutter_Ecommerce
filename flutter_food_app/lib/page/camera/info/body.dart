import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'detail/category.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

var controller = new MaskedTextController(mask: '000.000.000');

List<String> nameMenu = [
  "Lựa chọn danh mục",
  "Thêm giá trước khi giảm",
  "Thêm giá sau khi giảm",
  "Thêm đơn vị",
  "Địa chỉ",
  "Số điện thoại"
];

List<String> nameOption = [
  "Rau củ",
  "100.000.000 VNĐ",
  "50.000 VNĐ",
  "Kg",
  "123 Đường lên đỉnh Olympia F.15 Q.TB, TP.HCM",
  '+84 123 456 789',
];

class BodyInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BodyInfoState();
}

class BodyInfoState extends State<BodyInfo> {
  String titleInput = "";
  String contentInput = "";
  final myControllerTitle = new TextEditingController();
  final myControllerContent = new TextEditingController();

  @override
  void initState() {
    super.initState();

    myControllerTitle.addListener(_changeTitleInput);
    myControllerContent.addListener(_changeContentInput);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myControllerTitle.dispose();
    myControllerContent.dispose();
    super.dispose();
  }

  _changeTitleInput() {
    setState(() {
      titleInput = myControllerTitle.text;
    });
  }

  _changeContentInput() {
    setState(() {
      contentInput = myControllerContent.text;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.only(top: 16.0),
            content: Container(
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
                    height: 16.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 0.5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, right: 16.0),
                    child: TextField(
                      controller: controller,
                      maxLength: 11,
                      textDirection: TextDirection.rtl,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: false),
                      decoration: InputDecoration(
                        counterStyle: TextStyle(fontSize: 0),
                        hintText: "Nhập giá",
                        suffixText: 'VNĐ',
                        suffixStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        prefix: Container(
                          width: 16,
                          height: 16,
                        )
                      ),
                      cursorColor: colorActive,
                      maxLines: 1,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.0), bottomLeft: Radius.circular(8.0))
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
    final widthAddress = 150.0;
    return GestureDetector(
      onTap: () {

        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Theme(
            data: new ThemeData(
              primaryColor: titleInput.isEmpty ? Colors.redAccent : colorActive,
              primaryColorDark: titleInput.isEmpty ? Colors.red : Colors.green,
            ),
            child: new Container(
              decoration: BoxDecoration(color: Colors.white),
              child: new TextField(
                cursorColor: colorActive,
                controller: myControllerTitle,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: colorInactive)),
                  hintText: 'Nhập tiêu đề bài viết',
                  hintStyle: TextStyle(
                    fontFamily: "Ralway",
                    fontSize: 12,
                  ),
                  labelText: "Tiêu đề bài viết",
                  labelStyle: TextStyle(
                      fontFamily: "Ralway",
                      fontSize: 14,
                      color: Colors.blue
                  ),
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12
                ),
                autofocus: false,
              ),
            ),
          ),
          new Theme(
            data: new ThemeData(
              primaryColor: contentInput.isEmpty ? Colors.redAccent : colorActive,
              primaryColorDark: contentInput.isEmpty ? Colors.red : Colors.green,
            ),
            child: new Container(
              margin: EdgeInsets.only(top: 16.0),
              decoration: BoxDecoration(color: Colors.white),
              child: new TextField(
                cursorColor: colorActive,
                controller: myControllerContent,
                textAlign: TextAlign.start,
                maxLines: 10,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: colorInactive)),
                  hintText: 'Nhập nội dung bài viết',
                  hintStyle: TextStyle(
                    fontFamily: "Ralway",
                    fontSize: 12,
                  ),
                  labelText: "Nội dung bài viết",
                  labelStyle: TextStyle(
                    fontFamily: "Ralway",
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12
                ),
                autofocus: false,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Text(
              'Nội dung càng rõ ràng, càng nhiều người quan tâm!',
              style: TextStyle(fontSize: 12),
            ),
          ),

          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: nameMenu.length,
            itemBuilder: (BuildContext context, int index) =>  GestureDetector(
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
                        nameMenu[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: index != 4 ? widthAddress - 18 : MediaQuery.of(context).size.width - 150,
                              padding: EdgeInsets.only(right: 10.0),
                              child: Text(
                                nameOption[index],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                TextStyle(color: colorInactive, fontSize: 12),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                switch (index) {
                  case 0: {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryRadio()),
                    );
                  }
                  break;

                  case 1: {
                    _showDialog();
                  }
                  break;

                  case 2: {
                    _showDialog();
                  }
                  break;
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
