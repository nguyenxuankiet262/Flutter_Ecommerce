import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/fcm.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/admin_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/page/admin/report/slider.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class ListReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListReportState();
}

class ListReportState extends State<ListReport> {
  AdminBloc adminBloc;
  ApiBloc apiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of(context);
    adminBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    adminBloc.changeReportList(null);
  }

  _showBottomSheetBar(String des) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          final size = MediaQuery.of(context).size;
          final height = size.height - 60;
          return Container(
            height: height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 16.0, left: 16.0),
                  child: Text(
                    'NỘI DUNG',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: height - 60,
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Scrollbar(
                      child: ListView(
                    children: <Widget>[
                      Text(
                        des,
                        style: TextStyle(
                          fontFamily: "Ralway",
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )),
                ),
              ],
            ),
          );
        });
  }

  String _nameChildMenu(String idType) {
    for (int i = 1; i < apiBloc.currentState.listMenu.length; i++) {
      for (int j = 1;
          j < apiBloc.currentState.listMenu[i].listChildMenu.length;
          j++) {
        if (idType == apiBloc.currentState.listMenu[i].listChildMenu[j].id) {
          return apiBloc.currentState.listMenu[i].listChildMenu[j].name;
        }
      }
    }
    return "";
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
            itemCount: state.listReports.length,
            itemBuilder: (BuildContext context, int index) => Container(
                  margin: EdgeInsets.only(
                      top: 16.0,
                      bottom:
                          index == state.listReports.length - 1 ? 16.0 : 0.0),
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
                                            state.listReports[index].idUser)));
                              },
                              child: Text(
                                state.listReports[index].userReport.name,
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
                                        builder: (context) => Post(
                                            state.listReports[index].product
                                                .id)));
                              },
                              child: Text(
                                "sản phẩm",
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
                              state.listReports[index].reason == "1"
                                  ? reportStrings[0]
                                  : state.listReports[index].reason == "2"
                                      ? reportStrings[1]
                                      : state.listReports[index].reason == "3"
                                          ? reportStrings[2]
                                          : state.listReports[index].reason ==
                                                  "4"
                                              ? reportStrings[3]
                                              : state.listReports[index].reason,
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
                              Helper().formatDay(state.listReports[index].time),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Ralway",
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoAnotherPage(
                                            state.listReports[index].product
                                                .idUser)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 16.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        state.listReports[index].product.user
                                            .avatar,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    border: Border.all(
                                        color: colorInactive, width: 1)),
                                width: 50.0,
                                height: 50.0,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InfoAnotherPage(
                                                state.listReports[index].product
                                                    .idUser)));
                                  },
                                  child: Text(
                                    state.listReports[index].product.user.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Ralway",
                                        fontSize: 15),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      Helper().timeAgo(state
                                          .listReports[index].product.date),
                                      style: TextStyle(
                                          color: colorInactive,
                                          fontSize: 13,
                                          fontFamily: "Ralway",
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(top: 16, left: 16.0, right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Danh mục: ",
                                    style: TextStyle(
                                        fontFamily: "Ralway",
                                        fontWeight: FontWeight.bold,
                                        color: colorInactive),
                                  ),
                                  Text(
                                    _nameChildMenu(state
                                        .listReports[index].product.idType),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Ralway",
                                        color: colorFB),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  state.listReports[index].product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Ralway"),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    Helper().onFormatPrice(state
                                        .listReports[index]
                                        .product
                                        .currentPrice),
                                    style: TextStyle(
                                        color: colorActive,
                                        fontFamily: "Ralway",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: 4.0, left: 2.0),
                                    child: Text(
                                      '/',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 10.0,
                                    ),
                                    child: Text(
                                      state.listReports[index].product.unit,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Helper().onCalculatePercentDiscount(
                                              state.listReports[index].product
                                                  .initPrice,
                                              state.listReports[index].product
                                                  .currentPrice) ==
                                          "0%"
                                      ? Container()
                                      : Text(
                                          Helper().onFormatPrice(state
                                              .listReports[index]
                                              .product
                                              .initPrice),
                                          style: TextStyle(
                                            color: colorInactive,
                                            fontFamily: "Ralway",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 32),
                                  child: LayoutBuilder(
                                    builder: (context, size) {
                                      var span = TextSpan(
                                        text: state.listReports[index].product
                                            .description,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Ralway",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );

                                      var tp = TextPainter(
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        textDirection: TextDirection.ltr,
                                        text: span,
                                      );
                                      tp.layout(maxWidth: size.maxWidth);
                                      var exceeded = tp.didExceedMaxLines;
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text.rich(
                                              span,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                              color: Colors.white,
                                              child: exceeded
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        _showBottomSheetBar(
                                                            state
                                                                .listReports[
                                                                    index]
                                                                .product
                                                                .description);
                                                      },
                                                      child: Text(
                                                        "Xem thêm",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Ralway"),
                                                      ))
                                                  : Container())
                                        ],
                                      );
                                    },
                                  ))
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: SliderReport(index),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 34),
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
                                        "Xóa bài",
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
                                    String tokenSeller = state.listReports[index].product.user.token;
                                    int check = await deleteReportByAdmin(
                                        adminBloc,
                                        state.listReports[index].product.id,
                                        state.listReports[index].id,
                                        index);
                                    if (check == 1) {
                                      if (tokenSeller != null) {
                                        await sendNotification(
                                            "Sản phẩm bị hủy",
                                            "Bạn có 1 sản phẩm bị hủy!",
                                            tokenSeller);
                                      }
                                      Toast.show("Xóa bài thành công!",
                                          _contextDialog);
                                      Navigator.of(_contextDialog).pop();
                                    } else {
                                      Toast.show(
                                          "Xóa bài không thành công!",
                                          context);
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
                                          "Hủy",
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
                                        int check = await solveReport(adminBloc,
                                            state.listReports[index].id, index);
                                        if (check == 1) {
                                          Toast.show(
                                              "Hủy bài viết thành công!",
                                              _contextDialog);
                                          Navigator.of(_contextDialog).pop();
                                        } else {
                                          Toast.show(
                                              "Hủy bài viết không thành công!",
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
