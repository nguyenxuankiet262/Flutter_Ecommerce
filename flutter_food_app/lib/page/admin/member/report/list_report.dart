import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/admin_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class ListUserReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListUserReportState();
}

class ListUserReportState extends State<ListUserReport> {
  AdminBloc adminBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    adminBloc.changeUserReportList(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: adminBloc,
      builder: (context, AdminState state) {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.listUserReport.length,
            itemBuilder: (BuildContext context, int index) => Container(
                  margin: EdgeInsets.only(
                      top: 16.0,
                      bottom: index == state.listUserReport.length - 1
                          ? 16.0
                          : 0.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: colorInactive, width: 0.5))),
                        padding: EdgeInsets.all(16.0),
                        child: Wrap(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoAnotherPage(
                                            state.listUserReport[index].idUserReport)));
                              },
                              child: Text(
                                state.listUserReport[index].userReport.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Ralway"),
                              ),
                            ),
                            Text(
                              " đã báo cáo ",
                              style: TextStyle(
                                  fontFamily: "Ralway",
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoAnotherPage(
                                            state.listUserReport[index].idUser)));
                              },
                              child: Text(
                                state.listUserReport[index].user.username,
                                style: TextStyle(
                                    fontFamily: "Ralway",
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Text(
                              " này vì lí do ",
                              style: TextStyle(
                                  fontFamily: "Ralway",
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              state.listUserReport[index].reason == "1"
                                  ? reportUserStrings[0]
                                  : state.listUserReport[index].reason == "2"
                                  ? reportUserStrings[1]
                                  : state.listUserReport[index].reason,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Ralway",
                                  color: colorActive),
                            ),
                            Text(
                              " vào lúc ",
                              style: TextStyle(
                                  fontFamily: "Ralway",
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              Helper().formatDay(state.listUserReport[index].day),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Ralway",
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => InfoAnotherPage(state.listUserReport[index].idUser)),
                                );
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: colorInactive, width: 0.5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            state.listUserReport[index].user.avatar
                                        )
                                    )
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 16.0, top: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => InfoAnotherPage(state.listUserReport[index].idUser)),
                                        );
                                      },
                                      child: Text(
                                        state.listUserReport[index].user.name,
                                        style: TextStyle(
                                            fontFamily: "Ralway",
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text(
                                        state.listUserReport[index].user.username + " đã tham gia " + Helper().timeAgo(state.listUserReport[index].user.day),
                                        style: TextStyle(
                                            fontFamily: "Ralway",
                                            fontSize: 12,
                                            color: colorInactive,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            )
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
                                        child: Icon(Icons.block,
                                            color: colorIconBottomBar),
                                      ),
                                      Text(
                                        "Khóa",
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
                                  } else {
                                    new Future.delayed(
                                        const Duration(seconds: 1), () {
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
                                        child: Icon(Icons.remove_red_eye,
                                            color: colorIconBottomBar),
                                      ),
                                      Text(
                                        "Xem xét",
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
                                    int check = await updateInReviewUser(adminBloc, state.listUserReport[index].user.id, true, 1, index);
                                    if(check == 1){
                                      Toast.show("Đã chuyển " + state.listUserReport[index].user.username + " sang Xem xét!", context);
                                      Navigator.of(_contextDialog).pop();
                                    }
                                    else if(check == 0){
                                      Toast.show("Không thành công!", context);
                                      Navigator.of(_contextDialog).pop();
                                    }
                                    else{
                                      Toast.show("Lỗi hệ thống!", context);
                                      Navigator.of(_contextDialog).pop();
                                    }
                                  } else {
                                    new Future.delayed(
                                        const Duration(seconds: 1), () {
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
                            Expanded(
                              child: GestureDetector(
                                  child: Container(
                                    color: colorInactive.withOpacity(0.1),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Icon(FontAwesomeIcons.trashAlt,
                                              size: 20,
                                              color: colorIconBottomBar),
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
                                    {
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
                                        int check = await solveUserReport(adminBloc,
                                            state.listUserReport[index].id, index);
                                        if (check == 1) {
                                          Toast.show(
                                              "Bỏ qua thành công!",
                                              _contextDialog);
                                          Navigator.of(_contextDialog).pop();
                                        } else {
                                          Toast.show(
                                              "Bỏ qua không thành công!",
                                              context);
                                          Navigator.of(_contextDialog).pop();
                                        }
                                      } else {
                                        new Future.delayed(
                                            const Duration(seconds: 1), () {
                                          Navigator.of(_contextDialog).pop();
                                          Toast.show("Vui lòng kiểm tra mạng!",
                                              context,
                                              gravity: Toast.CENTER,
                                              backgroundColor: Colors.black87);
                                        });
                                      }
                                    }
                                  }),
                              flex: 1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
      },
    );
  }
}
