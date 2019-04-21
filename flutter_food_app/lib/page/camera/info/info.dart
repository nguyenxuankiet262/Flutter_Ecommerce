import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_camera_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter/services.dart';
import 'header.dart';
import 'body.dart';
import 'package:toast/toast.dart';

class InfoPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoPostState();
}

class InfoPostState extends State<InfoPost> {
  DetailCameraBloc blocProvider;
  @override
  void initState() {
    super.initState();
    blocProvider = BlocProvider.of<DetailCameraBloc>(context);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  void _clearBloc(){
    blocProvider.changeImageList(blocProvider.initialState.imagePaths);
    blocProvider.changeTitle(blocProvider.initialState.title);
    blocProvider.changeContent(blocProvider.initialState.content);
    blocProvider.changeIndexCategory(blocProvider.initialState.indexCategory, blocProvider.initialState.indexChildCategory);
    blocProvider.changePriceBefore(blocProvider.initialState.priceBefore);
    blocProvider.changePriceAfter(blocProvider.initialState.priceAfter);
  }

  Future<bool> _showDialog() {
    // flutter defined function
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Cảnh Báo!"),
              content: new Text("Bạn có chắc dừng việc đăng bài?"),
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
                  onPressed: (){
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    _clearBloc();
                  }
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void _showDialogPost() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.all(0.0),
            content: Container(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/images/gifs/relax.gif',
                        fit: BoxFit.fill,
                      ),
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                    ),
                    height: 150,
                  ),
                  Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        "Thông báo",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0, right: 20, left: 20),
                    child: Text(
                      'Để đảm bảo chất lượng hình ảnh và nội dung bài viết. Chúng tôi phải kiểm duyệt bài viết trước khi nó được đăng tải.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Ralway"),
                    ),
                  ),
                  Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 15.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              child: Container(
                                  margin: EdgeInsets.only(left: 16.0, right: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "HỦY",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12, fontFamily: "Ralway"),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                  margin: EdgeInsets.only(right: 16.0, left: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "ĐỒNG Ý",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12, fontFamily: "Ralway"),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              onTap: () {
                                _onSuccess();
                              },
                            ),
                            flex: 1,
                          )
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  _onSuccess() {
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Đang gửi...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    decoration: TextDecoration.none,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new CircularProgressIndicator(),
                ),
              ],
            ),
          ),
    );
    new Future.delayed(new Duration(seconds: 2), () {
      Toast.show('Đã gửi bài viết thành công!', context);
      Navigator.of(context).popUntil((route) => route.isFirst);
      _clearBloc();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            elevation: 0.5,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              'Thông tin bài viết',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              new Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    child: Text(
                      'ĐĂNG',
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: colorActive,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    onTap: () {
                      _showDialogPost();
                    },
                  ),
                ),
              ),
            ],
            leading: new Center(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
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
          body: Container(
            color: colorBackground,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  color: Colors.white,
                  child: HeaderInfo(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: BodyInfo(),
                ),
              ],
            ),
          )),
      onWillPop: _showDialog,
    );
  }
}
