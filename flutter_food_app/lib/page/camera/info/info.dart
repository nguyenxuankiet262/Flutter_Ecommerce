import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_camera_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter/services.dart';
import 'header.dart';
import 'body.dart';
import 'package:toast/toast.dart';
import 'package:image/image.dart' as Im;

class InfoPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoPostState();
}

class InfoPostState extends State<InfoPost> {
  DetailCameraBloc blocProvider;
  ApiBloc apiBloc;

  @override
  void initState() {
    super.initState();
    blocProvider = BlocProvider.of<DetailCameraBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  void _clearBloc() {
    blocProvider.changeImageList(blocProvider.initialState.imagePaths);
    blocProvider.changeTitle(blocProvider.initialState.title);
    blocProvider.changeContent(blocProvider.initialState.content);
    blocProvider.changeIndexCategory(blocProvider.initialState.indexCategory,
        blocProvider.initialState.indexChildCategory);
    blocProvider.changePriceBefore(blocProvider.initialState.priceBefore);
    blocProvider.changePriceAfter(blocProvider.initialState.priceAfter);
    blocProvider.changeUnit(blocProvider.initialState.unit);
  }

  Future<bool> _showDialog() {
    // flutter defined function
    return showDialog(
      barrierDismissible: false,
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
                    onPressed: () {
                      _clearBloc();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }),
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
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo!"),
          content: new Text('Để đảm bảo chất lượng hình ảnh và nội dung bài viết. Chúng tôi phải kiểm duyệt bài viết trước khi nó được đăng tải.'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Hủy"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
                child: new Text(
                  "Đồng ý",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: _onSuccess),
          ],
        );
      },
    );
  }

  Future<String> uploadToFirebase(String image) async {
    File imageFile = File(image);
    Im.Image imageResize = Im.decodeImage(imageFile.readAsBytesSync());
    Im.Image smallerImage = Im.copyResize(imageResize, width: 600, height: 600);
    FirebaseStorage _storage = FirebaseStorage.instance;
    StorageReference firebaseStorageRef = _storage.ref().child(
        'Flutter Images/' +
            apiBloc.currentState.mainUser.id +
            DateTime.now().millisecondsSinceEpoch.toString());
    StorageUploadTask task = firebaseStorageRef.putFile(imageFile..writeAsBytesSync(Im.encodeJpg(smallerImage, quality: 80)));
    StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _onUploadProduct() {
    if (blocProvider.currentState.imagePaths.isNotEmpty &&
        blocProvider.currentState.title != "" &&
        blocProvider.currentState.content != "" &&
        int.parse(
            Helper().onFormatDBPrice(blocProvider.currentState.priceBefore)) != 0 &&
        int.parse(
            Helper().onFormatDBPrice(blocProvider.currentState.priceAfter)) != 0) {
      if (int.parse(
          Helper().onFormatDBPrice(blocProvider.currentState.priceBefore)) >=
          int.parse(
              Helper().onFormatDBPrice(blocProvider.currentState.priceAfter))) {
        _showDialogPost();
      }
      else{
        Toast.show("Giá hiện tại phải nhỏ hơn giá khởi tạo!", context, gravity: Toast.CENTER);
      }
    }
    else{
      Toast.show("Vui lòng nhập đủ thông tin!", context, gravity: Toast.CENTER);
    }
  }

  _onSuccess() async {
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
    String img = "";
    for(int i = 0; i < blocProvider.currentState.imagePaths.length; i++){
      String temp = await uploadToFirebase(blocProvider.currentState.imagePaths[i]);
      if(i == 0){
       img = temp;
      }
      else{
        img += ";$temp";
      }
    }
    if(await addProduct(
        apiBloc.currentState.mainUser.id,
      blocProvider.currentState.title,
      blocProvider.currentState.content,
      img,
        apiBloc.currentState.listMenu[blocProvider.currentState.indexCategory].listChildMenu[blocProvider.currentState.indexChildCategory].id,
      Helper().onFormatDBPrice(blocProvider.currentState.priceBefore),
      Helper().onFormatDBPrice(blocProvider.currentState.priceAfter),
      blocProvider.currentState.unit
    )){
      Toast.show('Đã gửi bài viết thành công!', context, gravity: Toast.CENTER);
      Navigator.of(context).popUntil((route) => route.isFirst);
      _clearBloc();
    }
    else{
      Toast.show('Lỗi hệ thống!', context);
      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
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
                  onTap: _onUploadProduct,
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
        backgroundColor: colorBackground,
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
        ),
      ),
      onWillPop: _showDialog,
    );
  }
}
