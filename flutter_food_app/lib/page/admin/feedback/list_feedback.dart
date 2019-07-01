import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/admin_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class ListAdminFeedback extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListAdminFeedbackState();
}

class ListAdminFeedbackState extends State<ListAdminFeedback> {
  AdminBloc adminBloc;
  TextEditingController myControllerContent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myControllerContent = TextEditingController();
    adminBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myControllerContent.dispose();
    adminBloc.changeFeedbackList(null);
    super.dispose();
  }

  _showRepPopup(String idFeedback, int index) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Nội dung bài viết!"),
            content: Container(
              width: MediaQuery.of(context).size.width,
              color: colorBackground,
              child: TextField(
                controller: myControllerContent,
                textCapitalization: TextCapitalization.sentences,
                textAlign: TextAlign.start,
                inputFormatters: [LengthLimitingTextInputFormatter(1000)],
                maxLines: 10,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  border: InputBorder.none,
                  hintText: 'Nhập nội dung phản hồi',
                  hintStyle: TextStyle(
                      fontFamily: "Ralway", fontSize: 14, color: colorInactive),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(color: Colors.black, fontSize: 14),
                autofocus: true,
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Hủy"),
                onPressed: () {
                  myControllerContent.clear();
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                  child: new Text(
                    "Chấp nhận",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    if(myControllerContent.text.isEmpty){
                      Toast.show("Vui lòng nhập nội dung!", context, gravity: Toast.CENTER);
                    }
                    else{
                      BuildContext _contextDialog;
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            _contextDialog = context;
                            return SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50.0,
                            );
                          });
                      if (await Helper().check()) {
                        int check = await replyFeedback(adminBloc,
                            idFeedback, myControllerContent.text, index);
                        if (check == 1) {
                          Toast.show("Trả lời thành công!", context);
                          Navigator.of(_contextDialog).pop();
                          Navigator.of(context).pop();
                          myControllerContent.clear();
                        } else {
                          Toast.show("Trả lời không thành công!", context);
                          Navigator.of(_contextDialog).pop();
                        }
                      } else {
                        Navigator.of(_contextDialog).pop();
                        Toast.show("Vui lòng kiểm tra mạng!", context,
                            gravity: Toast.CENTER,
                            backgroundColor: Colors.black87);
                      }
                    }
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: adminBloc,
      builder: (context, AdminState state) {
        return ListView.builder(
          itemCount: state.listFeedbacks.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => Container(
                margin: EdgeInsets.only(
                    top: 16.0,
                    bottom: index == state.listFeedbacks.length - 1 ? 16.0 : 0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InfoAnotherPage(
                                              state.listFeedbacks[index]
                                                  .userFb)));
                                },
                                child: Text(
                                  state.listFeedbacks[index].user.username,
                                  style: TextStyle(
                                      fontFamily: "Ralway",
                                      fontWeight: FontWeight.bold,
                                      color: colorActive,
                                      fontSize: 16),
                                ),
                              ),
                              Text(
                                Helper()
                                    .timeAgo(state.listFeedbacks[index].day),
                                style: TextStyle(
                                    fontFamily: "Ralway",
                                    color: colorInactive,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              "Tiêu đề: " +  state.listFeedbacks[index].title,
                              style: TextStyle(
                                fontFamily: "Ralway",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              state.listFeedbacks[index].feedBack,
                              style: TextStyle(
                                fontFamily: "Ralway",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              child: Container(
                                color: colorInactive.withOpacity(0.1),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(Icons.check,
                                          color: colorIconBottomBar),
                                    ),
                                    Text(
                                      "Trả lời",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Ralway",
                                          color: colorIconBottomBar),
                                    )
                                  ],
                                ),
                              ),
                              onTap: (){
                                _showRepPopup(
                                    state.listFeedbacks[index].id, index);
                              },
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: GestureDetector(
                              child: Container(
                                color: colorInactive.withOpacity(0.1),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(FontAwesomeIcons.trashAlt,
                                          size: 20, color: colorIconBottomBar),
                                    ),
                                    Text(
                                      "Bỏ qua",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Ralway",
                                          color: colorIconBottomBar),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () async {
                                BuildContext _contextDialog;
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      _contextDialog = context;
                                      return SpinKitFadingCircle(
                                        color: Colors.white,
                                        size: 50.0,
                                      );
                                    });
                                if (await Helper().check()) {
                                  int check = await removeFeedback(
                                      adminBloc,
                                      state.listFeedbacks[index].id,
                                      index);
                                  if (check == 1) {
                                    Future.delayed(
                                        const Duration(milliseconds: 1000),
                                            () async {
                                          Toast.show("Bỏ qua thành công!",
                                              _contextDialog);
                                          Navigator.of(_contextDialog).pop();
                                        });
                                  } else {
                                    Future.delayed(
                                        const Duration(milliseconds: 1000),
                                            () {
                                          Toast.show(
                                              "Bỏ qua không thành công!",
                                              context);
                                          Navigator.of(_contextDialog).pop();
                                        });
                                  }
                                } else {
                                  new Future.delayed(const Duration(seconds: 1),
                                      () {
                                    Navigator.of(_contextDialog).pop();
                                    Toast.show(
                                        "Vui lòng kiểm tra mạng!", context,
                                        gravity: Toast.CENTER,
                                        backgroundColor: Colors.black87);
                                  });
                                }
                              },
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
        );
      },
    );
  }
}
