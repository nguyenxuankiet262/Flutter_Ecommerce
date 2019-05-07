import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_camera_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'detail/category.dart';

import 'row.dart';

List<String> nameMenu = [
  "Danh mục",
  "Giá trước khi giảm",
  "Giá sau khi giảm",
  "Đơn vị",
  "Địa chỉ",
  "Số điện thoại"
];

class BodyInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BodyInfoState();
}

class BodyInfoState extends State<BodyInfo> {
  String titleInput = "";
  String contentInput = "";
  TextEditingController myControllerTitle;
  TextEditingController myControllerContent;
  DetailCameraBloc blocProvider;

  @override
  void initState() {
    super.initState();
    blocProvider = BlocProvider.of<DetailCameraBloc>(context);
    myControllerTitle =
        new TextEditingController(text: blocProvider.currentState.title);
    myControllerContent =
        new TextEditingController(text: blocProvider.currentState.content);
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
      blocProvider.changeTitle(myControllerTitle.text);
    });
  }

  _changeContentInput() {
    setState(() {
      contentInput = myControllerContent.text;
      blocProvider.changeContent(myControllerContent.text);
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
          Container(
            width: double.infinity,
            color: colorBackground,
            padding: EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
            child: Text(
              "Tiêu đề bài viết",
              style: TextStyle(fontFamily: "Ralway", fontWeight: FontWeight.w500,),
            ),
          ),
          TextField(
            inputFormatters: [LengthLimitingTextInputFormatter(100)],
            controller: myControllerTitle,
            textAlign: TextAlign.start,
            maxLines: 1,
            decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
                hintText: 'Nhập tiêu đề bài viết',
                hintStyle: TextStyle(
                    fontFamily: "Ralway", fontSize: 14, color: colorInactive),
                filled: true,
                fillColor: Colors.white,
              suffixIcon: titleInput.isEmpty
                  ? null
                  : GestureDetector(
                onTap: () {
                  setState(() {
                    titleInput = "";
                    myControllerTitle.clear();
                    blocProvider.changeTitle(myControllerTitle.text);
                  });
                },
                child: Container(
                  color: Colors.white,
                  child: Icon(
                    FontAwesomeIcons
                        .solidTimesCircle,
                    color: colorInactive,
                    size: 15,
                  ),
                )
              ),
            ),
            style: TextStyle(color: Colors.black, fontSize: 14),
            autofocus: false,
          ),
          Container(
            width: double.infinity,
            color: colorBackground,
            padding: EdgeInsets.all(16.0),
            child: GestureDetector(
              child: Text(
                "Nội dung bài viết",
                style: TextStyle(fontFamily: "Ralway",fontWeight: FontWeight.w500,),
              ),
              onTap: (){
                print(contentInput);
              },
            )
          ),
          TextField(
            controller: myControllerContent,
            textAlign: TextAlign.start,
            maxLines: 10,
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                border: InputBorder.none,
                hintText: 'Nhập nội dung bài viết',
                hintStyle: TextStyle(
                    fontFamily: "Ralway", fontSize: 14, color: colorInactive),
                filled: true,
                fillColor: Colors.white,
                helperText: "Xin vui lòng nhập rõ nội dung",
              helperStyle: TextStyle(
                  fontFamily: "Ralway", fontSize: 14, color: colorInactive),
            ),
            style: TextStyle(color: Colors.black, fontSize: 14),
            autofocus: false,
            maxLength: 1000,
          ),
          Container(
            width: double.infinity,
            color: colorBackground,
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          Column(
            children: List.generate(nameMenu.length, (index) {
              return GestureDetector(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(color: colorInactive))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          nameMenu[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: "Ralway"
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  width: index != 4
                                      ? index == 0
                                      ? MediaQuery.of(context).size.width * 2 / 3
                                  : widthAddress - 18
                                      : MediaQuery.of(context).size.width * 3 / 4,
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: RowLayout(index)),
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
                    case 0:
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryRadio()),
                        );
                      }
                      break;
                  }
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
