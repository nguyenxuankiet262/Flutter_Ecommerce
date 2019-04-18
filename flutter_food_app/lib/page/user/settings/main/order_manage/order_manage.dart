import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'list_order.dart';

class OrderManage extends StatefulWidget{
  final bool isSellOrder;
  OrderManage(this.isSellOrder);
  @override
  State<StatefulWidget> createState() => OrderManageState();
}

class OrderManageState extends State<OrderManage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController =
    new TabController(vsync: this, length: tabsOrder.length + 1);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: tabsOrder.length,
      child: new Scaffold(
        body: new NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                elevation: 0.5,
                brightness: Brightness.light,
                title: new Text(
                  widget.isSellOrder ? 'Đơn hàng bán' : "Đơn hàng mua",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                pinned: true,
                floating: true,
                snap: true,
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 80,bottom: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                              "Tìm kiếm đơn hàng",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: colorInactive,
                                  fontFamily: "Ralway"
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ),
                forceElevated: innerBoxIsScrolled,
                bottom: new TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  tabs: new List.generate(tabsOrder.length, (index) {
                    return new Tab(text: tabsOrder[index].toUpperCase());
                  }),
                  controller: _tabController,
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: new List.generate(tabsOrder.length, (index) {
              return new ListOrder(index, widget.isSellOrder);
            }),
          ),
        ),
      ),
    );
  }
}