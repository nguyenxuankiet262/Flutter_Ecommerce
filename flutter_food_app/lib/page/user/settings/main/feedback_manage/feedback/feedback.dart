import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';
import 'package:flutter_food_app/api/model/feedback.dart';

class FeedbackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  ApiBloc apiBloc;
  String titleInput = "";
  String contentInput = "";
  final myControllerContent = new TextEditingController();
  final myControllerTitle = new TextEditingController();
  Future<bool> _showDialog() {
    // flutter defined function
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Cảnh Báo!"),
              content: new Text("Bạn có chắc dừng việc gửi phản hồi không?"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Không"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text(
                    "Có",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
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

  _changeContentInput() {
    setState(() {
      contentInput = myControllerContent.text;
    });
  }

  _changeTitleInput() {
    setState(() {
      titleInput = myControllerTitle.text;
    });
  }

  void _showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
          elevation: 0.5,
          brightness: Brightness.light,
          title: new Text(
            'Thêm phản hồi',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: <Widget>[
            new Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: GestureDetector(
                  child: Text(
                    'GỬI',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                        color: colorActive,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  onTap: () async {
                    if(titleInput.length > 0 && contentInput.length > 0){
                      _showLoading();
                      if(await addFeedback(apiBloc.currentState.mainUser.id, titleInput, contentInput) == 1){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Toast.show("Cảm ơn bạn đã phản hồi!", context, gravity: Toast.CENTER);
                        User user = apiBloc.currentState.mainUser;
                        user.listUnrepFeedback.insert(0, new Feedbacks(title: titleInput, feedBack: contentInput));
                      }
                      else{
                        Navigator.pop(context);
                        Toast.show("Lỗi hệ thống!", context, gravity: Toast.CENTER);
                      }
                    }
                    else{
                      Toast.show("Vui lòng nhập đủ thông tin!", context, gravity: Toast.CENTER);
                    }
                  },
                ),
              ),
            ),
          ],
          leading: new Center(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: GestureDetector(
                child: Text(
                  'HỦY',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                onTap: () {
                  _showDialog();
                },
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: colorBackground,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Tiêu đề",
                    style: TextStyle(
                        fontFamily: "Ralway", fontWeight: FontWeight.w600),
                  ),
                ),
                TextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  controller: myControllerTitle,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
                    hintText: 'Nhập tiêu đề bài viết',
                    hintStyle: TextStyle(
                        fontFamily: "Ralway", fontSize: 14, color: colorInactive),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: myControllerTitle.text.isEmpty
                        ? null
                        : GestureDetector(
                        onTap: () {
                          setState(() {
                            myControllerTitle.clear();
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          child: Icon(
                            FontAwesomeIcons.solidTimesCircle,
                            color: colorInactive,
                            size: 15,
                          ),
                        )),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  autofocus: false,
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Miêu tả vấn đề",
                    style: TextStyle(
                        fontFamily: "Ralway", fontWeight: FontWeight.w600),
                  ),
                ),
                TextField(
                  controller: myControllerContent,
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
                ),
              ],
            ),
          ),
        ));
  }
}
