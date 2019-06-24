import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/info_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/info_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/camera/camera.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'info.dart';
import 'private_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image/image.dart' as Im;

class PrivateManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PrivateManageState();
}

class PrivateManageState extends State<PrivateManage> {
  double heightContainer = 300;
  var top = 0.0;
  ApiBloc apiBloc;
  InfoBloc infoBloc;
  bool isCamera = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    infoBloc = BlocProvider.of<InfoBloc>(context);
    infoBloc.changeCover(apiBloc.currentState.mainUser.coverphoto);
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
  }

  _showDialog() {
    // flutter defined function
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Cảnh Báo!"),
          content: new Text("Bạn có chắc dừng việc chỉnh sửa?"),
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
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }),
          ],
        );
      },
    ) ??
        false;
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

  _onBackPress(InfoState infoState, ApiState state){
    if((infoState.avatar != state.mainUser.avatar) ||
        (infoState.coverphoto != state.mainUser.coverphoto) ||
        (infoState.username != state.mainUser.username) ||
        (infoState.address != state.mainUser.address) ||
        (infoState.phone != state.mainUser.phone) ||
        (infoState.link != state.mainUser.link) ||
        (infoState.intro != state.mainUser.intro) ||
        (infoState.name != state.mainUser.name)
    ){
      _showDialog();
    }
    else{
      Navigator.pop(context);
    }
  }

  Future<String> uploadToFirebase(String image, bool isAvatar) async {
    File imageFile = File(image);
    Im.Image imageResize = Im.decodeImage(imageFile.readAsBytesSync());
    Im.Image smallerImage = Im.copyResize(imageResize, width: isAvatar ? 200 : 500, height: isAvatar ? 200 : 500);
    FirebaseStorage _storage = FirebaseStorage.instance;
    StorageReference firebaseStorageRef = _storage.ref().child('Flutter Images/' + apiBloc.currentState.mainUser.id + DateTime.now().millisecondsSinceEpoch.toString() + ".jpg");
    StorageUploadTask task = firebaseStorageRef.putFile(imageFile..writeAsBytesSync(Im.encodeJpg(smallerImage, quality: 100)));
    StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: infoBloc,
      builder: (context, InfoState infoState){
        return BlocBuilder(
          bloc: apiBloc,
          builder: (context, ApiState state){
            return WillPopScope(
              onWillPop: (){
                _onBackPress(infoState, state);
                return Future.value(false);
              },
              child: Scaffold(
                  appBar: AppBar(
                    elevation: 0.5,
                    brightness: Brightness.light,
                    title: new Text(
                      'Chỉnh sửa trang cá nhân',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    actions: <Widget>[
                      IconButton(
                        onPressed: () async {
                          _showLoading();
                          if(infoState.username.isNotEmpty && infoState.name.isNotEmpty){
                            if(infoState.username != apiBloc.currentState.mainUser.username) {
                              int check_info = await checkInfoUser(
                                  infoState.username);
                              if(check_info == 1){
                                String avatar = infoState.avatar;
                                String cover = infoState.coverphoto;
                                if(infoState.avatar != apiBloc.currentState.mainUser.avatar){
                                  avatar = await uploadToFirebase(infoState.avatar, true);
                                }
                                if(infoState.coverphoto != apiBloc.currentState.mainUser.coverphoto){
                                  cover = await uploadToFirebase(infoState.coverphoto, false);
                                }
                                int check_changeInfo = await changeInfoUser(apiBloc.currentState.mainUser.id,
                                  infoState.username,
                                  infoState.name,
                                  infoState.phone,
                                  infoState.address,
                                  infoState.link != null ? infoState.link : "",
                                  infoState.intro != null ? infoState.intro : "",
                                  cover,
                                  avatar,
                                );
                                if(check_changeInfo == 1){
                                  Navigator.pop(context);
                                  User user = apiBloc.currentState.mainUser;
                                  user.username = infoState.username;
                                  user.name = infoState.name;
                                  user.phone = infoState.phone;
                                  user.address = infoState.address;
                                  user.link = infoState.link;
                                  user.intro = infoState.intro;
                                  user.coverphoto = cover;
                                  user.avatar = avatar;
                                  apiBloc.changeMainUser(user);
                                  infoBloc.changeInfo(infoState.username, infoState.phone, infoState.address, infoState.name, infoState.intro, infoState.link);
                                  infoBloc.changeAvatar(avatar);
                                  infoBloc.changeCover(cover);
                                  Toast.show("Cập nhật thông tin thành công!", context);
                                }
                              }
                              else if(check_info == 2){
                                Navigator.pop(context);
                                Toast.show("Tên tài khoản đã có người sử dụng!", context);
                              }
                              else{
                                Navigator.pop(context);
                                Toast.show("Lỗi hệ thống!", context);
                              }
                            }
                            else{
                              String avatar = infoState.avatar;
                              String cover = infoState.coverphoto;
                              if(infoState.avatar != apiBloc.currentState.mainUser.avatar) {
                                avatar = await uploadToFirebase(infoState.avatar, true);
                              }
                              if(infoState.coverphoto != apiBloc.currentState.mainUser.coverphoto){
                                cover = await uploadToFirebase(infoState.coverphoto, false);
                              }
                              int check_changeInfo = await changeInfoUser(apiBloc.currentState.mainUser.id,
                                infoState.username,
                                infoState.name,
                                infoState.phone,
                                infoState.address,
                                infoState.link != null ? infoState.link : "",
                                infoState.intro != null ? infoState.intro : "",
                                cover,
                                avatar,
                              );
                              if(check_changeInfo == 1){
                                Navigator.pop(context);
                                User user = apiBloc.currentState.mainUser;
                                user.username = infoState.username;
                                user.name = infoState.name;
                                user.phone = infoState.phone;
                                user.address = infoState.address;
                                user.link = infoState.link;
                                user.intro = infoState.intro;
                                user.coverphoto = cover;
                                user.avatar = avatar;
                                apiBloc.changeMainUser(user);
                                infoBloc.changeInfo(infoState.username, infoState.phone, infoState.address, infoState.name, infoState.intro, infoState.link);
                                infoBloc.changeAvatar(avatar);
                                infoBloc.changeCover(cover);
                                Toast.show("Cập nhật thông tin thành công!", context);
                              }
                              else if(check_changeInfo == 2){
                                Navigator.pop(context);
                                Toast.show("Tên tài khoản đã có người sử dụng!", context);
                              }
                              else{
                                Navigator.pop(context);
                                Toast.show("Lỗi hệ thống!", context);
                              }
                            }
                          }
                          else{
                            Navigator.pop(context);
                            Toast.show("Không thể thiếu họ tên hoặc username!", context);
                          }
                        },
                        icon: Icon(
                          Icons.done,
                          color: colorActive,
                        ),
                      )
                    ],
                  ),
                  backgroundColor: Colors.white,
                  body: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      child: NotificationListener(
                          onNotification: (v) {
                            if (v is ScrollUpdateNotification)
                              setState(() => top -= v.scrollDelta / 2);
                          },
                          child: Container(
                              color: Colors.white,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: top,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: heightContainer,
                                      decoration: !infoState.coverphoto.contains("https://")
                                          ? BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                              File(infoState.coverphoto)),
                                        ),
                                      )
                                          : BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              state.mainUser.coverphoto),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView(
                                    children: <Widget>[
                                      Container(
                                        child: Stack(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: (){
                                                if (!isCamera) {
                                                  setState(() {
                                                    isCamera = true;
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CameraPage(2)),
                                                  );
                                                  setState(() {
                                                    isCamera = false;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: heightContainer,
                                                color: Colors.transparent
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                            Positioned(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 60,
                                                color: Colors.white,
                                              ),
                                              bottom: 0.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height: heightContainer + 60,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 2.0),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    100.0))),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border:
                                                                  Border.all(
                                                                      width:
                                                                      0.5),
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                      .circular(
                                                                      100.0))),
                                                              child: GestureDetector(
                                                                onTap: (){
                                                                  if (!isCamera) {
                                                                    setState(() {
                                                                      isCamera = true;
                                                                    });
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              CameraPage(1)),
                                                                    );
                                                                    setState(() {
                                                                      isCamera = false;
                                                                    });
                                                                  }
                                                                },
                                                                child: ClipOval(
                                                                  child: !infoState.avatar.contains("https://")
                                                                      ? Image.file(
                                                                    File(infoState
                                                                        .avatar),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    width:
                                                                    150.0,
                                                                    height:
                                                                    150.0,
                                                                  )
                                                                      : Image
                                                                      .network(
                                                                    state
                                                                        .mainUser
                                                                        .avatar,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    width:
                                                                    150.0,
                                                                    height:
                                                                    150.0,
                                                                  ),
                                                                ),
                                                              )
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (!isCamera) {
                                                    setState(() {
                                                      isCamera = true;
                                                    });
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CameraPage(1)),
                                                    );
                                                    setState(() {
                                                      isCamera = false;
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      color: colorContainer,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2.0),
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100.0))),
                                                  child: Icon(
                                                    FontAwesomeIcons.camera,
                                                    size: 17,
                                                  ),
                                                ),
                                              ),
                                              bottom: 2.0,
                                              left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  1.7,
                                            ),
                                            Positioned(
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (!isCamera) {
                                                    setState(() {
                                                      isCamera = true;
                                                    });
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CameraPage(2)),
                                                    );
                                                    setState(() {
                                                      isCamera = false;
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      color: colorContainer,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1.0),
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                                  child: Icon(
                                                    FontAwesomeIcons.camera,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              right: 16.0,
                                              bottom: 76,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        color: Colors.white,
                                        child: Container(
                                            height: 40,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 15.0),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            color: Colors.white,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "THÔNG TIN RIÊNG TƯ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            )),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: PrivateInfo(),
                                      ),
                                      Container(
                                        height: 40,
                                        color: Colors.white,
                                        child: Container(
                                            height: 40,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 15.0),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            color: Colors.white,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "THÔNG TIN CHUNG",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            )),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: Info(),
                                      ),
                                    ],
                                  ),
                                ],
                              )))))
            );
          },
        );
      },
    );
  }
}
