import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter/services.dart';
import 'header.dart';
import 'package:flutter_food_app/app.dart';
import 'package:camera/camera.dart';
import 'body.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:toast/toast.dart';

class InfoPost extends StatefulWidget {
  List<CameraDescription> cameras;

  InfoPost(this.cameras);

  @override
  State<StatefulWidget> createState() => InfoPostState();
}

class InfoPostState extends State<InfoPost> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
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
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyMainPage(widget.cameras)),
                        (Route<dynamic> route) => false);
              },
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
        builder: (_) =>
            AssetGiffyDialog(
              imagePath: 'assets/images/gifs/relax.gif',
              title: Text('Thông báo',
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
              description: Text(
                'Để đảm bảo chất lượng hình ảnh và nội dung bài viết. Chúng tôi phải kiểm duyệt bài viết trước khi nó được đăng tải.',
                textAlign: TextAlign.center,
              ),
              onOkButtonPressed: () {
                _onSuccess();
              },
            ));
  }

  Future _onSuccess() {
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
      Navigator.pop(context); //pop dialog
      Toast.show('Đã gửi bài viết thành công!', context);
      new Future.delayed(new Duration(seconds: 1), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MyMainPage(widget.cameras)),
                (Route<dynamic> route) => false);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
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
                padding: EdgeInsets.only(right: 10),
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
              padding: EdgeInsets.only(right: 10),
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
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: HeaderInfo(widget.cameras),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: BodyInfo(),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
      onWillPop: _showDialog,
    );
  }
}
