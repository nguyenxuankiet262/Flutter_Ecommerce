import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'product/product.dart';
import 'user/user.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: TabBar(
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
        body: TabBarView(
          controller: _tabController,
          children: [
            ProductContent(),
            UserContent(),
          ],
        ));
  }
}
