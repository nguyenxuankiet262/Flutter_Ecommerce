import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';

class Info extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoState();
}

class InfoState extends State<Info> {
  String nameInput = "";
  String usernameInput = "";
  String webInput = "";
  String contentInput = "";
  String addressInput = "";

  final myControllerName = new TextEditingController();
  final myControllerUserName = new TextEditingController();
  final myControllerWeb = new TextEditingController();
  final myControllerContent = new TextEditingController();
  final myControllerPhone = new TextEditingController();
  final myControllerAddress = new TextEditingController();

  @override
  void initState() {
    super.initState();

    myControllerName.value = new TextEditingController.fromValue(new TextEditingValue(text: "Trần Văn Mèo")).value;
    myControllerUserName.value = new TextEditingController.fromValue(new TextEditingValue(text: "meow_meow")).value;
    myControllerWeb.value = new TextEditingController.fromValue(new TextEditingValue(text: "http://fb.com/kiet.s.lo")).value;
    myControllerContent.value = new TextEditingController.fromValue(new TextEditingValue(text: "Mình bắt chước loài mèo kêu nha\nKêu cùng anh méo meo meo meo\nEm chỉ muốn ôm anh nhõng nhẽo\nAizo meo meo meo meo mèo")).value;
    myControllerPhone.value = new TextEditingController.fromValue(new TextEditingValue(text: "+84 123 456 789")).value;
    myControllerAddress.value = new TextEditingController.fromValue(new TextEditingValue(text: "123 Đường lên đỉnh Olympia")).value;

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
    setState(() {
      addressInput = myControllerAddress.text;
    });
  }

  _changeNameInput() {
    setState(() {
      nameInput = myControllerName.text;
    });
  }

  _changeUsernameInput() {
    setState(() {
      usernameInput = myControllerUserName.text;
    });
  }

  _changeWebInput() {
    setState(() {
      webInput = myControllerWeb.text;
    });
  }

  _changeContentInput() {
    setState(() {
      contentInput = myControllerContent.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Theme(
          data: new ThemeData(
            primaryColor: nameInput.isEmpty ? Colors.redAccent : colorActive,
            primaryColorDark: nameInput.isEmpty ? Colors.red : Colors.green,
          ),
          child: new Container(
            margin: EdgeInsets.only(top: 10.0, right: 20, left: 20),
            decoration: BoxDecoration(color: Colors.white),
            child: new TextField(
              cursorColor: colorActive,
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
            primaryColor: usernameInput.isEmpty ? Colors.redAccent : colorActive,
            primaryColorDark: usernameInput.isEmpty ? Colors.red : Colors.green,
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
              maxLength: 10,
              autofocus: false,
            ),
          ),
        ),
        new Theme(
          data: new ThemeData(
            primaryColor: webInput.isEmpty ? Colors.redAccent : colorActive,
            primaryColorDark: webInput.isEmpty ? Colors.red : Colors.green,
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
            primaryColor: contentInput.isEmpty ? Colors.redAccent : colorActive,
            primaryColorDark: contentInput.isEmpty ? Colors.red : Colors.green,
          ),
          child: new Container(
            margin: EdgeInsets.only(top: 30.0, right: 20, left: 20, bottom: 20.0),
            decoration: BoxDecoration(color: Colors.white),
            child: new TextField(
              cursorColor: colorActive,
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
          child: new TextField(
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
        ),
        new Theme(
          data: new ThemeData(
            primaryColor: addressInput.isEmpty ? Colors.redAccent : colorActive,
            primaryColorDark: addressInput.isEmpty ? Colors.red : Colors.green,
          ),
          child: new Container(
            margin: EdgeInsets.only(top: 10.0, right: 20, left: 20, bottom: 20.0),
            decoration: BoxDecoration(color: Colors.white),
            child: new TextField(
              cursorColor: colorActive,
              controller: myControllerAddress,
              decoration: new InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: colorInactive, width: 0.5),
                ),
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
          ),
        ),
      ],
    );
  }
}
