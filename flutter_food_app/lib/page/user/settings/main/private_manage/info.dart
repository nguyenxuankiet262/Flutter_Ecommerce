import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_account_kit/flutter_account_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/info_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/settings/main/private_manage/address.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class Info extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InforState();
}

class InforState extends State<Info> {
  ApiBloc apiBloc;
  FlutterAccountKit akt = FlutterAccountKit();
  InfoBloc infoBloc;

  final myControllerName = new TextEditingController();
  final myControllerUserName = new TextEditingController();
  final myControllerWeb = new TextEditingController();
  final myControllerContent = new TextEditingController();
  final myControllerPhone = new TextEditingController();
  final myControllerAddress = new TextEditingController();

  Future<void> initAccountkit() async {
    try {
      final theme = AccountKitTheme(
          headerBackgroundColor: colorActive,
          buttonBackgroundColor: colorActive,
          buttonBorderColor: Colors.white,
          buttonTextColor: Colors.white);
      await akt.configure(Config()
        ..facebookNotificationsEnabled = true
        ..receiveSMS = true
        ..readPhoneStateEnabled = true
        ..theme = theme
      );
    } on PlatformException {
      print('Failed to initialize account kit');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
    });
  }

  _changeAddress(String address){
    myControllerAddress.text = address;
    infoBloc.changeInfo(
        apiBloc.currentState.mainUser.username,
        apiBloc.currentState.mainUser.phone,
        address,
        apiBloc.currentState.mainUser.name,
        apiBloc.currentState.mainUser.intro,
        apiBloc.currentState.mainUser.link);
  }

  _navigateToAddressPage(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AddressPage(_changeAddress)));
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

  Future<void> _changePhone() async {
    initAccountkit();
    final result = await akt.logInWithPhone();
    if (result.status == LoginStatus.cancelledByUser) {
    } else if (result.status == LoginStatus.error) {
      Toast.show("Lỗi hệ thống!", context);
    } else {
      _showLoading();
      Future.delayed(const Duration(milliseconds: 500), () async {
        Account account = await akt.currentAccount;
        if (account != null) {
          PhoneNumber phoneNumber = account.phoneNumber;
          int check = await checkInfoUser(phoneNumber.toString());
          print(phoneNumber.toString());
          if(check == 0){
            Navigator.pop(context);
            Toast.show("Lỗi hệ thống!", context);
          }
          else if(check == 1){
            myControllerPhone.text = phoneNumber.toString();
            infoBloc.changeInfo(
                apiBloc.currentState.mainUser.username,
                myControllerPhone.text,
                apiBloc.currentState.mainUser.address,
                apiBloc.currentState.mainUser.name,
                apiBloc.currentState.mainUser.intro,
                apiBloc.currentState.mainUser.link);
            Navigator.pop(context);
          }
          else{
            Navigator.pop(context);
            Toast.show("Số điện thoại đã có người sử dụng!", context);
          }
        } else {
          Navigator.pop(context);
          print("not found");
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    infoBloc = BlocProvider.of<InfoBloc>(context);

    myControllerName.value = new TextEditingController.fromValue(new TextEditingValue(text: apiBloc.currentState.mainUser.name)).value;
    myControllerUserName.value = new TextEditingController.fromValue(new TextEditingValue(text: apiBloc.currentState.mainUser.username)).value;
    myControllerWeb.value = new TextEditingController.fromValue(new TextEditingValue(
        text: apiBloc.currentState.mainUser.link != null ? apiBloc.currentState.mainUser.link : ""
    )).value;
    myControllerContent.value = new TextEditingController.fromValue(new TextEditingValue(
        text: apiBloc.currentState.mainUser.intro != null ? apiBloc.currentState.mainUser.intro : "")).value;
    myControllerPhone.value = new TextEditingController.fromValue(new TextEditingValue(text: apiBloc.currentState.mainUser.phone)).value;
    myControllerAddress.value = new TextEditingController.fromValue(new TextEditingValue(text: apiBloc.currentState.mainUser.address)).value;

    myControllerAddress.addListener(_changeAddressInput);
    myControllerName.addListener(_changeNameInput);
    myControllerUserName.addListener(_changeUsernameInput);
    myControllerWeb.addListener(_changeWebInput);
    myControllerContent.addListener(_changeContentInput);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myControllerName.dispose();
    myControllerUserName.dispose();
    myControllerWeb.dispose();
    myControllerContent.dispose();
    myControllerPhone.dispose();
    myControllerAddress.dispose();
    super.dispose();
  }

  _changeAddressInput() {
    infoBloc.changeInfo(
        infoBloc.currentState.username,
        infoBloc.currentState.phone,
        myControllerAddress.text,
        infoBloc.currentState.name,
        infoBloc.currentState.intro,
        infoBloc.currentState.link);
  }

  _changeNameInput() {
    print(myControllerName.text);
    infoBloc.changeInfo(
        infoBloc.currentState.username,
        infoBloc.currentState.phone,
        infoBloc.currentState.address,
        myControllerName.text,
        infoBloc.currentState.intro,
        infoBloc.currentState.link);
  }

  _changeUsernameInput() {
    infoBloc.changeInfo(
        myControllerUserName.text,
        infoBloc.currentState.phone,
        infoBloc.currentState.address,
        infoBloc.currentState.name,
        infoBloc.currentState.intro,
        infoBloc.currentState.link);
  }

  _changeWebInput() {
    infoBloc.changeInfo(
        infoBloc.currentState.username,
        infoBloc.currentState.phone,
        infoBloc.currentState.address,
        infoBloc.currentState.name,
        infoBloc.currentState.intro,
        myControllerWeb.text);
  }

  _changeContentInput() {
    infoBloc.changeInfo(
        infoBloc.currentState.username,
        infoBloc.currentState.phone,
        infoBloc.currentState.address,
        infoBloc.currentState.name,
        myControllerContent.text,
        infoBloc.currentState.link);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Theme(
              data: new ThemeData(
                primaryColor: myControllerName.text.isEmpty ? Colors.redAccent : colorActive,
                primaryColorDark: myControllerName.text.isEmpty ? Colors.red : Colors.green,
              ),
              child: new Container(
                margin: EdgeInsets.only(top: 10.0, right: 20, left: 20),
                decoration: BoxDecoration(color: Colors.white),
                child: new TextField(
                  cursorColor: colorActive,
                  textCapitalization: TextCapitalization.words,
                  controller: myControllerName,
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: colorInactive, width: 0.5),
                    ),
                    hintText: 'Nhập họ và tên',
                    hintStyle: TextStyle(
                      fontFamily: "Ralway",
                      fontSize: 12,
                    ),
                    labelText: "Họ và tên",
                    labelStyle: TextStyle(
                        fontFamily: "Ralway",
                        fontSize: 14,
                        color: Colors.blue
                    ),
                  ),
                  maxLength: 50,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black
                  ),
                  autofocus: false,
                ),
              ),
            ),
            new Theme(
              data: new ThemeData(
                primaryColor: myControllerUserName.text.isEmpty ? Colors.redAccent : colorActive,
                primaryColorDark: myControllerUserName.text.isEmpty ? Colors.red : Colors.green,
              ),
              child: new Container(
                margin: EdgeInsets.only(top: 10.0, right: 20, left: 20),
                decoration: BoxDecoration(color: Colors.white),
                child: new TextField(
                  cursorColor: colorActive,
                  controller: myControllerUserName,
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: colorInactive, width: 0.5),
                    ),
                    hintText: 'Nhập username',
                    hintStyle: TextStyle(
                      fontFamily: "Ralway",
                      fontSize: 12,
                    ),
                    labelText: "Username",
                    labelStyle: TextStyle(
                        fontFamily: "Ralway",
                        fontSize: 14,
                        color: Colors.blue
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black
                  ),
                  maxLength: 15,
                  autofocus: false,
                ),
              ),
            ),
            new Theme(
              data: new ThemeData(
                primaryColor: myControllerWeb.text.isEmpty ? Colors.redAccent : colorActive,
                primaryColorDark: myControllerWeb.text.isEmpty ? Colors.red : Colors.green,
              ),
              child: new Container(
                margin: EdgeInsets.only(top: 10.0, right: 20, left: 20),
                decoration: BoxDecoration(color: Colors.white),
                child: new TextField(
                  cursorColor: colorActive,
                  controller: myControllerWeb,
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: colorInactive, width: 0.5),
                    ),
                    hintText: 'Nhập trang web',
                    hintStyle: TextStyle(
                      fontFamily: "Ralway",
                      fontSize: 12,
                    ),
                    labelText: "Trang web",
                    labelStyle: TextStyle(
                        fontFamily: "Ralway",
                        fontSize: 14,
                        color: Colors.blue
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black
                  ),
                  autofocus: false,
                ),
              ),
            ),
            new Theme(
              data: new ThemeData(
                primaryColor: myControllerContent.text.isEmpty ? Colors.redAccent : colorActive,
                primaryColorDark: myControllerContent.text.isEmpty ? Colors.red : Colors.green,
              ),
              child: new Container(
                margin: EdgeInsets.only(top: 30.0, right: 20, left: 20, bottom: 20.0),
                decoration: BoxDecoration(color: Colors.white),
                child: new TextField(
                  cursorColor: colorActive,
                  textCapitalization: TextCapitalization.sentences,
                  controller: myControllerContent,
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: colorInactive, width: 0.5),
                    ),
                    hintText: 'Nhập giới thiệu',
                    hintStyle: TextStyle(
                      fontFamily: "Ralway",
                      fontSize: 12,
                    ),
                    labelText: "Giới thiệu",
                    labelStyle: TextStyle(
                        fontFamily: "Ralway",
                        fontSize: 14,
                        color: Colors.blue
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black
                  ),
                  autofocus: false,
                  textAlign: TextAlign.start,
                  maxLines: null,
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.only(top: 10.0, right: 20, left: 20, bottom: 20.0),
              decoration: BoxDecoration(color: colorInactive.withOpacity(0.1)),
              child: Stack(
                children: <Widget>[
                  new TextField(
                    cursorColor: colorActive,
                    enabled: false,
                    controller: myControllerPhone,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: colorInactive)),
                      hintText: 'Nhập số điện thoại',
                      hintStyle: TextStyle(
                        fontFamily: "Ralway",
                        fontSize: 12,
                      ),
                      labelText: "Số điện thoại",
                      labelStyle: TextStyle(
                          fontFamily: "Ralway",
                          fontSize: 14,
                          color: Colors.blue
                      ),
                    ),
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                    ),
                    autofocus: false,
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.edit,
                          size: 20,
                          color: Colors.grey,
                        ),
                        onPressed: _changePhone,
                      ),
                    ),
                  )
                ],
              )
            ),
            new Container(
                margin: EdgeInsets.only(top: 10.0, right: 20, left: 20, bottom: 20.0),
                decoration: BoxDecoration(color: colorInactive.withOpacity(0.1)),
                child: Stack(
                  children: <Widget>[
                    new TextField(
                      cursorColor: colorActive,
                      enabled: false,
                      controller: myControllerAddress,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: colorInactive)),
                        hintText: 'Nhập địa chỉ',
                        hintStyle: TextStyle(
                          fontFamily: "Ralway",
                          fontSize: 12,
                        ),
                        labelText: "Địa chỉ",
                        labelStyle: TextStyle(
                            fontFamily: "Ralway",
                            fontSize: 14,
                            color: Colors.blue
                        ),
                      ),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black
                      ),
                      autofocus: false,
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.edit,
                            size: 20,
                            color: Colors.grey,
                          ),
                          onPressed: _navigateToAddressPage,
                        ),
                      ),
                    )
                  ],
                )
            ),
          ],
        );
      },
    );
  }
}
