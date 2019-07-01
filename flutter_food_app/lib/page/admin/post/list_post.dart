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
import 'package:flutter_food_app/page/admin/post/slider.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class ListUnprovePost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListUnprovePostState();
}

class ListUnprovePostState extends State<ListUnprovePost> {
  AdminBloc adminBloc;
  FunctionBloc functionBloc;
  ApiBloc apiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of(context);
    adminBloc = BlocProvider.of(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    adminBloc.changeUnprovedList(null);
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
            itemCount: state.listUnprovedProducts.length,
            itemBuilder: (BuildContext context, int index) => Container(
                  margin: EdgeInsets.only(
                      top: 16.0,
                      bottom: index == state.listUnprovedProducts.length - 1
                          ? 16.0
                          : 0.0),
                  height: 632,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                                            state.listUnprovedProducts[index]
                                                .idUser)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 16.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        state.listUnprovedProducts[index].user
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
                                                state.listUnprovedProducts[index]
                                                    .idUser)));
                                  },
                                  child: Text(
                                    state.listUnprovedProducts[index].user.name,
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
                                          .listUnprovedProducts[index].date),
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
                                        .listUnprovedProducts[index].idType),
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
                                  state.listUnprovedProducts[index].name,
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
                                        .listUnprovedProducts[index]
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
                                      state.listUnprovedProducts[index].unit,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Helper().onCalculatePercentDiscount(
                                              state.listUnprovedProducts[index]
                                                  .initPrice,
                                              state.listUnprovedProducts[index]
                                                  .currentPrice) ==
                                          "0%"
                                      ? Container()
                                      : Text(
                                          Helper().onFormatPrice(state
                                              .listUnprovedProducts[index]
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
                                        text: state.listUnprovedProducts[index]
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
                                                        _showBottomSheetBar(state
                                                            .listUnprovedProducts[
                                                                index]
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
                        child: SliderUnprovedPost(index),
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
                                        child: Icon(Icons.check,
                                            color: colorIconBottomBar),
                                      ),
                                      Text(
                                        "Phê duyệt",
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
                                    String tokenSeller = state
                                        .listUnprovedProducts[index].user.token;
                                    int check = await approvedPost(
                                        adminBloc,
                                        state.listUnprovedProducts[index].id,
                                        index);
                                    if (check == 1) {
                                      if (tokenSeller != null) {
                                        await sendNotification(
                                            "Sản phẩm được duyệt",
                                            "Bạn có 1 sản phẩm mới được duyệt!",
                                            tokenSeller);
                                      }
                                      Toast.show(
                                          "Phê duyệt thành công!", _contextDialog);
                                      Navigator.of(_contextDialog).pop();
                                    } else {
                                      Toast.show(
                                          "Phê duyệt không thành công!",
                                          _contextDialog);
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    String tokenSeller = state
                                        .listUnprovedProducts[index].user.token;
                                    int check = await deletePostByAdmin(
                                        adminBloc,
                                        state.listUnprovedProducts[index].id,
                                        index);
                                    if (check == 1) {
                                      if (tokenSeller != null) {
                                        await sendNotification(
                                            "Sản phẩm bị hủy",
                                            "Bạn có 1 sản phẩm bị hủy!",
                                            tokenSeller);
                                      }
                                      Toast.show("Hủy bài viết thành công!",
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
                ));
      },
    );
  }
}
