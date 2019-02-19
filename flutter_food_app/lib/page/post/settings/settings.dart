import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

class SettingsPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPostState();
}

List<Icon> iconList = [
  Icon(Icons.share, color: Colors.blue,),
  Icon(Icons.star, color: Colors.yellow,),
  Icon(Icons.block, color: Colors.red,),
];

List<String> nameList = [
  'Chia sẻ',
  'Lưu vào bookmark',
  'Báo cáo vi phạm',
];

class SettingsPostState extends State<SettingsPost> {
  String textInput = "";
  final myController = new TextEditingController();
  @override
  void initState() {
    super.initState();

    myController.addListener(_changeTextInput);
  }

  _changeTextInput() {
    setState(() {
      textInput = myController.text;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    super.dispose();
  }
  _showDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Báo cáo",
                    style: TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      controller: myController,
                      maxLengthEnforced: true,
                      maxLength: 100,
                      decoration: InputDecoration(
                        hintText: "Nhập bình luận",
                        border: InputBorder.none,
                      ),
                      cursorColor: colorActive,
                      maxLines: 4,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "ĐỒNG Ý",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      myController.clear();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text(
            'Tùy chỉnh',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          color: Colors.white,
          child: ListView.builder(
            itemCount: iconList.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                        color: colorInactive
                    ))
                ),
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    iconList[index],
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        nameList[index],
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: (){
                switch(index){
                  case 0: {
                    print('Tap 0');
                  }
                  break;
                  case 1: {
                    Toast.show('Đã lưu vào bookmark', context);
                  }
                  break;
                  case 2: {
                    _showDialog();
                  }
                  break;
                }
              },
            ),
          ),
        ));
  }
}
