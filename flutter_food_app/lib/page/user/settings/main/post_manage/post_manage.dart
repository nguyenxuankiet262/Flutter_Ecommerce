import 'package:flutter/material.dart';
import 'package:flutter_food_app/page/filter/filter.dart';
import 'package:toast/toast.dart';
import 'list_post.dart';
import 'package:flutter_food_app/const/color_const.dart';

List<String> nameList = [
  'Lọc',
  'Xóa tất cả',
];

class PostManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostManageState();
}

class PostManageState extends State<PostManage> {
  _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Cảnh Báo!"),
          content: new Text("Bạn có chắc muốn xóa tất cả không?"),
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
                Navigator.of(context).pop();
                Toast.show('Đã xóa tất cả', context);
              },
            ),
          ],
        );
      },
    );
  }
  _showBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 130.0,
            margin: EdgeInsets.all(15.0),
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15.0))
                        ),
                      ),
                    )
                ),
                ListView.builder(
                  itemCount: nameList.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              nameList[index],
                              style: TextStyle(
                                  fontSize: 14,
                                  color: index != 1 ? Colors.blue : Colors.red,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FilterPage(2),),
                              );
                              break;
                            case 1:
                              Navigator.pop(context);
                              _showDialog();
                              break;
                          }
                        },
                      ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(111.0), // here the desired height
        child: Column(
          children: <Widget>[
            AppBar(
              brightness: Brightness.light,
              title: new Text(
                "Quản lý bài viết",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              leading: GestureDetector(
                child: Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: (){
                    _showBottomSheet();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  )
                )
              ],
            ),
            Container(
                height: 55.0,
                color: Colors.white,
                padding:
                EdgeInsets.only(right: 16.0, left: 16.0, bottom: 14.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: colorInactive.withOpacity(0.2)),
                  child: Container(
                      margin: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ),
                          Text(
                            "Tìm kiếm bài viết, tác giả",
                            style: TextStyle(
                                fontSize: 14,
                                color: colorInactive,
                                fontFamily: "Ralway"),
                          )
                        ],
                      )),
                )),
          ],
        ),
      ),
      body: new ListPost(),
    );
  }
}
