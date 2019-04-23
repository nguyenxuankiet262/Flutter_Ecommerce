import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'list_order.dart';
import 'search/search.dart';

class OrderManage extends StatefulWidget{
  final bool isSellOrder;
  OrderManage(this.isSellOrder);
  @override
  State<StatefulWidget> createState() => OrderManageState();
}

class OrderManageState extends State<OrderManage> with SingleTickerProviderStateMixin{
  String _text = "";
  bool complete = false;
  bool isSearch = false;
  final myController = TextEditingController();
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController =
    new TabController(vsync: this, length: tabsOrder.length + 1);
    BlocProvider.of<BottomBarBloc>(context)
        .changeVisible(true);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    myController.dispose();
    super.dispose();
  }

  void changeHome() {
    _text = "";
    isSearch = false;
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
    myController.clear();
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      elevation: 0.0,
      brightness: Brightness.light,
      title: new Text(
        widget.isSellOrder ? 'Đơn hàng bán' : "Đơn hàng mua",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: tabsOrder.length,
      child: new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0.5,
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                pinned: true,
                floating: true,
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Column(
                    children: <Widget>[
                      buildAppBar(context),
                      isSearch
                          ? Container(
                          height: 55.0,
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              right: 16.0, left: 16.0, bottom: 14.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 16.0),
                                  padding:
                                  EdgeInsets.symmetric(vertical: 2.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      color:
                                      colorInactive.withOpacity(0.2)),
                                  child: Container(
                                      margin: EdgeInsets.only(left: 15.0),
                                      child: TextField(
                                        autofocus: true,
                                        controller: myController,
                                        textInputAction:
                                        TextInputAction.search,
                                        onChanged: (text) {
                                          setState(() {
                                            _text = text;
                                          });
                                        },
                                        onSubmitted: (newValue) {
                                          setState(() {
                                            BlocProvider.of<
                                                SearchInputBloc>(
                                                context)
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
                                          hintText:
                                          'Nhập tên/id đơn hàng',
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
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0)),
                                  color: colorInactive.withOpacity(0.2)),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.search,
                                    color: colorInactive,
                                    size: 18,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      "Tìm kiếm đơn hàng",
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
              return Stack(
                children: <Widget>[
                  SearchPage(index, widget.isSellOrder),
                  Visibility(
                    maintainState: false,
                    visible: isSearch ? false : true,
                    child: ListOrder(index, widget.isSellOrder),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}