import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/settings/main/order_manage/search/list_search_order.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'list_order.dart';

List<GlobalKey<ListSearchOrderPageState>> globalKey = [
  GlobalKey(),
  GlobalKey(),
  GlobalKey(),
];

class OrderManage extends StatefulWidget {
  final bool isSellOrder;

  OrderManage(this.isSellOrder);

  @override
  State<StatefulWidget> createState() => OrderManageState();
}

class OrderManageState extends State<OrderManage>
    with SingleTickerProviderStateMixin {
  bool complete = false;
  bool isSearch = false;
  final myController = TextEditingController();
  TabController _tabController;
  FocusScopeNode _focusA;
  FocusScopeNode _focusB;
  LoadingBloc loadingBloc;
  ApiBloc apiBloc;
  SearchInputBloc searchInputBloc;

  @override
  void initState() {
    super.initState();
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    searchInputBloc = BlocProvider.of<SearchInputBloc>(context);
    _focusA = FocusScopeNode();
    _focusB = FocusScopeNode();
    _tabController =
        new TabController(vsync: this, length: tabsOrder.length + 1);
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    _tabController.addListener(_onChange);
  }

  _onChange() {
    if (isSearch) {
      if (BlocProvider.of<SearchInputBloc>(context)
          .currentState
          .searchInput
          .isNotEmpty) {}
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    myController.dispose();
    _focusA.detach();
    _focusB.detach();
    super.dispose();
  }

  void changeHome() {
    setState(() {
      isSearch = false;
      myController.clear();
    });
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
    BlocProvider.of<SearchBloc>(context).changePage();
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      elevation: 0.0,
      brightness: Brightness.light,
      title: new Text(
        widget.isSellOrder ? 'Đơn hàng bán' : "Đơn hàng mua",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
    );
  }

  Future<bool> _onBackPressed() {
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    if (isSearch) {
      changeHome();
    } else {
      loadingBloc.changeLoadingDetail(true);
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: searchInputBloc,
      builder: (context, TextSearchState state) {
        return new WillPopScope(
            onWillPop: _onBackPressed,
            child: Container(
                color: Colors.white,
                child: Material(
                  child: SafeArea(
                      child: DefaultTabController(
                    length: tabsOrder.length,
                    child: Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        elevation: 0.0,
                        brightness: Brightness.light,
                        backgroundColor: Colors.white,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(90),
                          child: Column(
                            children: <Widget>[
                              buildAppBar(context),
                              Stack(
                                children: <Widget>[
                                  FocusScope(
                                      node: _focusA,
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context)
                                              .setFirstFocus(_focusB);
                                          BlocProvider.of<SearchBloc>(
                                              context)
                                              .changePage();
                                          setState(() {
                                            isSearch = true;
                                          });
                                        },
                                        child: Container(
                                          height: 41.0,
                                          color: Colors.white,
                                          padding: EdgeInsets.only(
                                              right: 16.0, left: 16.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          5.0)),
                                                  color: colorInactive
                                                      .withOpacity(0.2)),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.search,
                                                    color: colorInactive,
                                                    size: 18,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      "Tìm kiếm bài viết",
                                                      style: TextStyle(
                                                          fontFamily:
                                                          "Raleway",
                                                          color:
                                                          colorInactive,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      )),
                                  Visibility(
                                      visible: isSearch ? true : false,
                                      child: Container(
                                          height: 41.0,
                                          color: Colors.white,
                                          padding: EdgeInsets.only(
                                              right: 16.0, left: 16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 16.0),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 2.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            5.0)),
                                                        color: colorInactive
                                                            .withOpacity(
                                                            0.2)),
                                                    child: FocusScope(
                                                      node: _focusB,
                                                      child: Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              left:
                                                              15.0),
                                                          child: TextField(
                                                            autofocus: true,
                                                            controller:
                                                            myController,
                                                            textInputAction:
                                                            TextInputAction
                                                                .search,
                                                            onTap: () {
                                                              FocusScope.of(
                                                                  context)
                                                                  .setFirstFocus(
                                                                  _focusB);
                                                            },
                                                            onSubmitted:
                                                                (newValue) {
                                                              searchInputBloc
                                                                  .searchInput(
                                                                  1,
                                                                  newValue);
                                                              loadingBloc
                                                                  .changeLoadingSearch(
                                                                  true);
                                                              globalKey[0].currentState.onRefreshListSearchOrder();
                                                              globalKey[1].currentState.onRefreshListSearchOrder();
                                                              globalKey[2].currentState.onRefreshListSearchOrder();
                                                            },
                                                            style: TextStyle(
                                                                fontFamily:
                                                                "Ralway",
                                                                fontSize:
                                                                12,
                                                                color: Colors
                                                                    .black),
                                                            decoration:
                                                            InputDecoration(
                                                              border:
                                                              InputBorder
                                                                  .none,
                                                              hintText:
                                                              'Nhập tên bài viết',
                                                              hintStyle: TextStyle(
                                                                  color:
                                                                  colorInactive,
                                                                  fontFamily:
                                                                  "Ralway",
                                                                  fontSize:
                                                                  12),
                                                              icon: Icon(
                                                                Icons
                                                                    .search,
                                                                color:
                                                                colorInactive,
                                                                size: 20,
                                                              ),
                                                              suffixIcon: myController
                                                                  .text
                                                                  .isEmpty
                                                                  ? null
                                                                  : GestureDetector(
                                                                onTap:
                                                                    () {
                                                                  setState(() {
                                                                    myController.clear();
                                                                  });
                                                                },
                                                                child:
                                                                Icon(
                                                                  FontAwesomeIcons.solidTimesCircle,
                                                                  color:
                                                                  colorInactive,
                                                                  size:
                                                                  15,
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                    )),
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
                                                                color:
                                                                colorInactive,
                                                                fontSize:
                                                                12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                fontFamily:
                                                                "Ralway"),
                                                          ),
                                                        )),
                                                    onTap: () {
                                                      changeHome();
                                                    },
                                                  ))
                                            ],
                                          ))),
                                ],
                              ),
                              TabBar(
                                isScrollable: true,
                                indicatorColor: Colors.white,
                                unselectedLabelColor: Colors.grey,
                                labelColor: Colors.black,
                                tabs: new List.generate(
                                    tabsOrder.length, (index) {
                                  return new Tab(
                                      text: tabsOrder[index]
                                          .toUpperCase());
                                }),
                                controller: _tabController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: TabBarView(
                        controller: _tabController,
                        children: new List.generate(tabsOrder.length, (index) {
                          return Stack(
                            children: <Widget>[
                              Container(
                                color: colorBackground,
                                child: ListOrder(index, widget.isSellOrder),
                              ),
                              Visibility(
                                  maintainState: true,
                                  visible: isSearch ? true : false,
                                  child: state.searchInput.isNotEmpty
                                      ? Container(
                                          color: colorBackground,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListSearchOrder(key: globalKey[index],index: index,isSellOrder: widget.isSellOrder,),
                                        )
                                      : Scaffold(
                                          resizeToAvoidBottomPadding: false,
                                          backgroundColor: Colors.black54,
                                          body: Container(
                                            color: Colors.transparent,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: ListView(
                                              shrinkWrap: true,
                                            ),
                                          )))
                            ],
                          );
                        }),
                      ),
                    ),
                  )),
                  type: MaterialType.transparency,
                )));
      },
    );
  }
}