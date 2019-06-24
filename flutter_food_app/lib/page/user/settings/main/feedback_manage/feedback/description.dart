import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';

class DescriptionFeedback extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => DescriptionFeedbackState();
}

class DescriptionFeedbackState extends State<DescriptionFeedback>{
  String contentInput = "";
  final myControllerContent = new TextEditingController();
  @override
  void initState() {
    super.initState();
    myControllerContent.addListener(_changeContentInput);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myControllerContent.dispose();
    super.dispose();
  }

  _changeContentInput() {
    setState(() {
      contentInput = myControllerContent.text;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      controller: myControllerContent,
      textCapitalization: TextCapitalization.sentences,
      textAlign: TextAlign.start,
      maxLines: 10,
      decoration: new InputDecoration(
        border: InputBorder.none,
        hintText: 'Nhập nội dung bài viết',
        hintStyle: TextStyle(
          fontFamily: "Ralway",
          fontSize: 12,
          color: colorInactive
        ),
        filled: true,
        fillColor: Colors.white,
        helperText: "Xin vui lòng nhập rõ nội dung"
      ),
      style: TextStyle(
          color: Colors.black,
          fontSize: 12
      ),
      autofocus: false,
      maxLength: 1000,
    );
  }

}