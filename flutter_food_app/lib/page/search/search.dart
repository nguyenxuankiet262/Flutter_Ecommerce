import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'product/product.dart';
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
  TabController _tabController;
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
    );
  }
}
