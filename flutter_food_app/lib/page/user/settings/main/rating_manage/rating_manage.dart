import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/filter/filter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';
import 'list_rating.dart';
import 'search/search.dart';

List<String> nameList = [
  'Lọc',
  'Ẩn tất cả',
];

class RatingManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RatingManageState();
}

class RatingManageState extends State<RatingManage> {
  String _text = "";
  bool complete = false;
  bool isSearch = false;
  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BottomBarBloc>(context)
        .changeVisible(true);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  void changeHome() {
    _text = "";
    isSearch = false;
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
    myController.clear();
    BlocProvider.of<SearchBloc>(context).changePage();
  }

  _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Cảnh Báo!"),
          content: new Text("Bạn có chắc muốn ẩn tất cả không?"),
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
                Navigator.of(context).pop();
                Toast.show('Đã ẩn tất cả', context);
              },
            ),
          ],
        );
      },
    );
  }

  _showBottomSheet() {
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                    )),
                ListView.builder(
                  itemCount: nameList.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 15.0),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              nameList[index],
                              style: TextStyle(
                                  fontSize: 14,
                                  color: index != 1 ? Colors.blue : Colors.red,
                                  fontWeight: FontWeight.w500),
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
                                  builder: (context) => FilterPage(4),
                                ),
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
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(111.0), // here the desired height
        child: Column(
          children: <Widget>[
            AppBar(
              brightness: Brightness.light,
              title: new Text(
                "Đánh giá",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                    onPressed: () {
                      _showBottomSheet();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ))
              ],
            ),
            isSearch
                ? Container(
                height: 55.0,
                color: Colors.white,
                padding: EdgeInsets.only(
                    right: 16.0, left: 16.0, bottom: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 16.0),
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            color: colorInactive.withOpacity(0.2)),
                        child: Container(
                            margin: EdgeInsets.only(left: 15.0),
                            child: TextField(
                              autofocus: true,
                              controller: myController,
                              textInputAction: TextInputAction.search,
                              onChanged: (text) {
                                setState(() {
                                  _text = text;
                                });
                              },
                              onSubmitted: (newValue) {
                                setState(() {
                                  BlocProvider.of<SearchInputBloc>(context)
                                      .searchInput(1, newValue);
                                  isSearch = true;
                                });
                              },
                              style: TextStyle(
                                  fontFamily: "Ralway",
                                  fontSize: 12,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nhập tên bài viết, người đăng',
                                hintStyle: TextStyle(
                                    color: colorInactive,
                                    fontFamily: "Ralway",
                                    fontSize: 12),
                                icon: Icon(
                                  Icons.search,
                                  color: colorInactive,
                                  size: 20,
                                ),
                                suffixIcon: _text.isEmpty
                                    ? null
                                    : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _text = "";
                                      myController.clear();
                                    });
                                  },
                                  child: Icon(
                                    FontAwesomeIcons
                                        .solidTimesCircle,
                                    color: colorInactive,
                                    size: 15,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      flex: 9,
                    ),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          child: Container(
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  "Hủy",
                                  style: TextStyle(
                                      color: colorInactive,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Ralway"),
                                ),
                              )),
                          onTap: () {
                            setState(() {
                              changeHome();
                            });
                          },
                        ))
                  ],
                ))
                : GestureDetector(
              onTap: () {
                BlocProvider.of<SearchBloc>(context).changePage();
                setState(() {
                  isSearch = true;
                });
              },
              child: Container(
                height: 55.0,
                color: Colors.white,
                padding: EdgeInsets.only(
                    right: 16.0, left: 16.0, bottom: 14.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)),
                        color: colorInactive.withOpacity(0.2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: colorInactive,
                          size: 18,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Tìm kiếm bài viết, người đăng",
                            style: TextStyle(
                                fontFamily: "Raleway",
                                color: colorInactive,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          SearchPage(),
          Visibility(
            maintainState: true,
            visible: isSearch ? false : true,
            child: new ListRating(),
          )
        ],
      )
    );
  }
}
