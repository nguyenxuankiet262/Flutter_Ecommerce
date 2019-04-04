import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'product/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'user/user.dart';
import 'product/search_product.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  int _index = 1;
  String searchInput = "";
  bool complete = false;
  bool isSearch = false;
  final myController = TextEditingController();
  TabController _tabController;
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    _focus = new FocusNode();
    _focus.addListener(() {
      if (!_focus.hasFocus && myController.text.isEmpty) {
        setState(() {
          isSearch = false;
        });
      }
    });
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        setState(() {
          _index = 1;
        });
      } else {
        setState(() {
          _index = 2;
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    _focus.dispose();
    super.dispose();
  }

  _changeSearch() {
    setState(() {
      searchInput = myController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0.0,
          brightness: Brightness.light,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: colorInactive.withOpacity(0.2)),
                    child: isSearch
                        ? Container(
                            margin: EdgeInsets.only(left: 15.0),
                            child: TextField(
                              autofocus: true,
                              focusNode: _focus,
                              controller: myController,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (newValue){
                                setState(() {
                                  print(searchInput);
                                  searchInput = newValue;
                                  print(searchInput);
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
                                    fontSize: 14),
                                icon: Icon(
                                  Icons.search,
                                  color: colorInactive,
                                  size: 18,
                                ),
                                suffixIcon:
                                    searchInput.isEmpty || !_focus.hasFocus
                                        ? null
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                myController.clear();
                                              });
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.solidTimesCircle,
                                              color: colorInactive,
                                              size: 15,
                                            ),
                                          ),
                              ),
                            ))
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                isSearch = true;
                              });
                            },
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
                            ))),
              ),
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleSpacing: 0.0,
            title: TabBar(
              controller: _tabController,
              indicatorColor: colorActive,
              unselectedLabelColor: Colors.grey,
              labelColor: colorActive,
              tabs: [
                Tab(
                  child: Text(
                    "Sản phẩm",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Ralway"),
                  ),
                ),
                Tab(
                  child: Text(
                    "Người dùng",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Ralway",
                    ),
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              _index == 1 && searchInput.isNotEmpty
                  ? SearchProduct()
                  : ProductContent(),
              _index == 2 && searchInput.isNotEmpty && !_focus.hasFocus
                  ? SearchProduct()
                  : UserContent(),
            ],
          ),
        ));
  }
}
