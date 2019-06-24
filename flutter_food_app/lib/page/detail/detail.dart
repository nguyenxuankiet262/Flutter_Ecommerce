import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/load_more_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/detail_page_state.dart';
import 'package:flutter_food_app/common/state/list_product_state.dart';
import 'package:flutter_food_app/common/state/load_more_state.dart';
import 'package:flutter_food_app/common/state/loading_state.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/page/filter/common/filter.dart';
import 'package:flutter_food_app/page/search/search.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_child_menu.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/detail/menu.dart';
import 'package:toast/toast.dart';
import 'list_post.dart';

class ListAllPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListAllPostState();
}

class _ListAllPostState extends State<ListAllPost>
    with AutomaticKeepAliveClientMixin {
  String address = "";
  bool isSearch = false;
  final myController = TextEditingController();
  FunctionBloc functionBloc;
  ScrollController _hideButtonController;
  FocusScopeNode _focusA;
  FocusScopeNode _focusB;
  DetailPageBloc detailPageBloc;
  LocationBloc locationBloc;
  ApiBloc apiBloc;
  final listProductBloc = ListProductBloc();
  final loadMoreBloc = LoadMoreBloc();
  LoadingBloc loadingBloc;
  ListSearchProductBloc listSearchProductBloc;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshHeaderState> _connectorHeaderKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKeyGrid =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshFooterState> _connectorFooterKeyGrid =
      new GlobalKey<RefreshFooterState>();

  void changeDetail() {
    setState(() {
      isSearch = false;
      myController.clear();
    });
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
    BlocProvider.of<SearchBloc>(context).changePage();
    listSearchProductBloc.changeListSearchProduct(new List<Product>());
  }

  Function _callBack;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listSearchProductBloc = BlocProvider.of<ListSearchProductBloc>(context);
    _hideButtonController = new ScrollController();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    if (locationBloc.currentState.indexCity != 0) {
      if (locationBloc.currentState.indexProvince != 0) {
        address = locationBloc.currentState
                    .nameProvinces[locationBloc.currentState.indexCity]
                [locationBloc.currentState.indexProvince] +
            ", " +
            locationBloc
                .currentState.nameCities[locationBloc.currentState.indexCity];
      } else {
        address = locationBloc
            .currentState.nameCities[locationBloc.currentState.indexCity];
      }
    }
    apiBloc = BlocProvider.of<ApiBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    detailPageBloc = BlocProvider.of<DetailPageBloc>(context);
    loadingBloc.changeLoadingDetail(true);
    (() async {
      if (await Helper().check()) {
        fetchProductOfMenu(
            listProductBloc,
            loadingBloc,
            apiBloc.currentState
                .listMenu[detailPageBloc.currentState.indexCategory].id,
            detailPageBloc.currentState.code.toString(),
            detailPageBloc.currentState.min.toString(),
            detailPageBloc.currentState.max.toString(),
            "1",
            "10",
            address);
      } else {
        new Future.delayed(const Duration(seconds: 1), () {
          Toast.show("Vui lòng kiểm tra mạng!", context,
              gravity: Toast.CENTER, backgroundColor: Colors.black87);
        });
      }
    })();
    //fetchProduct(apiBloc.currentState.listChildMenu[0].id);
    BlocProvider.of<FunctionBloc>(context).isLoading(_isLoading);
    _focusA = FocusScopeNode();
    _focusB = FocusScopeNode();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        BlocProvider.of<BottomBarBloc>(context).changeVisible(false);
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
      }
    });
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    _callBack = functionBloc.currentState.onBackPressed;
    functionBloc.onBackPressed(_onBackPressed);
    functionBloc.onFetchProductChildMenu(_onFetchProductChildMenu);
    functionBloc.onFetchProductMenu(_onFetchProductMenu);
  }

  _onDefault() {
    listProductBloc.changeListProduct(listProductBloc.initialState.listProduct);
    loadMoreBloc.changeLoadMore(1, 10);
  }

  void _onFetchProductChildMenu(String idChildMenu, String code, String min,
      String max, String begin, String end, String address) {
    fetchProductOfChildMenu(listProductBloc, loadingBloc, idChildMenu, code,
        min, max, begin, end, address);
  }

  void _onFetchProductMenu(String idMenu, String code, String min, String max,
      String begin, String end, String address) {
    fetchProductOfMenu(listProductBloc, loadingBloc, idMenu, code, min, max,
        begin, end, address);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    _focusA.detach();
    _focusB.detach();
    _hideButtonController.dispose();
    listProductBloc.dispose();
    super.dispose();
  }

  _isLoading() {
    _onDefault();
    _hideButtonController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
  }

  AppBar buildAppBar(BuildContext context, DetailPageState state) {
    return new AppBar(
      elevation: 0.0,
      brightness: Brightness.light,
      title: new Text(
        state.indexChildCategory == 0
            ? apiBloc.currentState.listMenu[state.indexCategory].name
            : apiBloc.currentState.listMenu[state.indexCategory]
                .listChildMenu[state.indexChildCategory].name,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<ListProductBloc>(bloc: listProductBloc),
        BlocProvider<LoadMoreBloc>(
          bloc: loadMoreBloc,
        )
      ],
      child: WillPopScope(
          onWillPop: _onBackPressed,
          child: BlocBuilder(
            bloc: detailPageBloc,
            builder: (context, DetailPageState detailstate) {
              return BlocBuilder(
                bloc: loadMoreBloc,
                builder: (context, LoadMoreState loadmoreState) {
                  return Container(
                      color: Colors.white,
                      child: Material(
                          child: SafeArea(
                              child: NestedScrollView(
                                  physics: NeverScrollableScrollPhysics(),
                                  controller: _hideButtonController,
                                  headerSliverBuilder:
                                      (context, innerBoxScrolled) => [
                                            SliverAppBar(
                                              automaticallyImplyLeading: false,
                                              elevation: 0.0,
                                              brightness: Brightness.light,
                                              backgroundColor: Colors.white,
                                              pinned: false,
                                              floating: true,
                                              snap: true,
                                              bottom: PreferredSize(
                                                preferredSize:
                                                    Size.fromHeight(41),
                                                child: Container(
                                                  child: Column(
                                                    children: <Widget>[
                                                      buildAppBar(
                                                          context, detailstate),
                                                      Stack(
                                                        children: <Widget>[
                                                          FocusScope(
                                                            node: _focusA,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                BlocProvider.of<
                                                                            BottomBarBloc>(
                                                                        context)
                                                                    .changeVisible(
                                                                        false);
                                                                BlocProvider.of<
                                                                            SearchBloc>(
                                                                        context)
                                                                    .changePage();
                                                                FocusScope.of(
                                                                        context)
                                                                    .setFirstFocus(
                                                                        _focusB);
                                                                setState(() {
                                                                  isSearch =
                                                                      true;
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 41.0,
                                                                color: Colors
                                                                    .white,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            16.0,
                                                                        left:
                                                                            16.0),
                                                                child:
                                                                    Container(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                5.0)),
                                                                            color: colorInactive.withOpacity(
                                                                                0.2)),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: <
                                                                              Widget>[
                                                                            Icon(
                                                                              Icons.search,
                                                                              color: colorInactive,
                                                                              size: 18,
                                                                            ),
                                                                            Container(
                                                                              margin: EdgeInsets.only(left: 5.0),
                                                                              child: Text(
                                                                                "Tìm kiếm bài viết, người đăng",
                                                                                style: TextStyle(fontFamily: "Raleway", color: colorInactive, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                              ),
                                                            ),
                                                          ),
                                                          Visibility(
                                                              visible: isSearch
                                                                  ? true
                                                                  : false,
                                                              child: Container(
                                                                  height: 41.0,
                                                                  color: Colors
                                                                      .white,
                                                                  padding: EdgeInsets.only(
                                                                      right:
                                                                          16.0,
                                                                      left:
                                                                          16.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.only(right: 16.0),
                                                                          padding:
                                                                              EdgeInsets.symmetric(vertical: 2.0),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                                              color: colorInactive.withOpacity(0.2)),
                                                                          child:
                                                                              FocusScope(
                                                                            node:
                                                                                _focusB,
                                                                            child: Container(
                                                                                margin: EdgeInsets.only(left: 15.0),
                                                                                child: TextField(
                                                                                  autofocus: true,
                                                                                  controller: myController,
                                                                                  textInputAction: TextInputAction.search,
                                                                                  onTap: () {
                                                                                    FocusScope.of(context).setFirstFocus(_focusB);
                                                                                  },
                                                                                  onSubmitted: (newValue) {
                                                                                    setState(() {
                                                                                      BlocProvider.of<SearchInputBloc>(context).searchInput(1, newValue);
                                                                                      loadingBloc.changeLoadingSearch(true);
                                                                                      listSearchProductBloc.changeListSearchProduct(new List<Product>());
                                                                                      if (detailstate.indexChildCategory == 0) {
                                                                                        searchProductsOfMenu(listSearchProductBloc, loadingBloc, apiBloc.currentState.listMenu[detailstate.indexCategory].id, newValue, detailstate.code.toString(), detailstate.min.toString(), detailstate.max.toString(), "1", "10", address);
                                                                                      } else {
                                                                                        searchProductsOfChildMenu(listSearchProductBloc, loadingBloc, apiBloc.currentState.listMenu[detailstate.indexCategory].listChildMenu[detailstate.indexChildCategory].id, newValue, detailstate.code.toString(), detailstate.min.toString(), detailstate.max.toString(), "1", "10", address);
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  style: TextStyle(fontFamily: "Ralway", fontSize: 12, color: Colors.black),
                                                                                  decoration: InputDecoration(
                                                                                    border: InputBorder.none,
                                                                                    hintText: 'Nhập tên bài viết, người đăng',
                                                                                    hintStyle: TextStyle(color: colorInactive, fontFamily: "Ralway", fontSize: 12),
                                                                                    icon: Icon(
                                                                                      Icons.search,
                                                                                      color: colorInactive,
                                                                                      size: 20,
                                                                                    ),
                                                                                    suffixIcon: myController.text.isEmpty
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
                                                                                )),
                                                                          ),
                                                                        ),
                                                                        flex: 9,
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              GestureDetector(
                                                                            child: Container(
                                                                                color: Colors.white,
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "Hủy",
                                                                                    style: TextStyle(color: colorInactive, fontSize: 12, fontWeight: FontWeight.w600, fontFamily: "Ralway"),
                                                                                  ),
                                                                                )),
                                                                            onTap:
                                                                                () {
                                                                              BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
                                                                              changeDetail();
                                                                            },
                                                                          ))
                                                                    ],
                                                                  )))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SliverPersistentHeader(
                                              pinned: true,
                                              delegate: _SliverAppBarDelegate(
                                                child: PreferredSize(
                                                    preferredSize:
                                                        Size.fromHeight(46),
                                                    child: BlocBuilder(
                                                      bloc: detailPageBloc,
                                                      builder: (context,
                                                          DetailPageState
                                                              state) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      color:
                                                                          colorInactive,
                                                                      width:
                                                                          0.5))),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    functionBloc
                                                                        .currentState
                                                                        .navigateToFilterHome();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          height:
                                                                              30,
                                                                          margin: EdgeInsets.only(
                                                                              top:
                                                                                  8.0,
                                                                              bottom:
                                                                                  8.0,
                                                                              right:
                                                                                  8.0,
                                                                              left:
                                                                                  16.0),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              border: Border(right: BorderSide(color: colorInactive, width: 0.5))),
                                                                          child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      "Danh mục",
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(fontSize: 12, fontFamily: "Ralway", color: colorInactive, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    Text(
                                                                                      apiBloc.currentState.listMenu[state.indexCategory].name,
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(fontSize: 12, fontFamily: "Ralway", fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                flex: 9,
                                                                              ),
                                                                              Icon(
                                                                                Icons.arrow_drop_down,
                                                                              )
                                                                            ],
                                                                          )),
                                                                ),
                                                                flex: 3,
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    functionBloc
                                                                        .currentState
                                                                        .navigateToFilterHome();
                                                                  },
                                                                  child: Container(
                                                                      height: 30,
                                                                      decoration: BoxDecoration(color: Colors.white, border: Border(right: BorderSide(color: colorInactive, width: 0.5))),
                                                                      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: <
                                                                            Widget>[
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                Text(
                                                                                  "Danh mục con",
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(fontSize: 12, fontFamily: "Ralway", color: colorInactive, fontWeight: FontWeight.w500),
                                                                                ),
                                                                                Text(
                                                                                  apiBloc.currentState.listMenu[state.indexCategory].listChildMenu[state.indexChildCategory].name,
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(fontSize: 12, fontFamily: "Ralway", fontWeight: FontWeight.w500),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            flex:
                                                                                9,
                                                                          ),
                                                                          Icon(
                                                                            Icons.arrow_drop_down,
                                                                          )
                                                                        ],
                                                                      )),
                                                                ),
                                                                flex: 2,
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                FilterPage(),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                      height: 30,
                                                                      color: Colors.white,
                                                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: <
                                                                            Widget>[
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                Text(
                                                                                  "Sắp xếp/Lọc",
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(fontSize: 12, fontFamily: "Ralway", color: colorInactive, fontWeight: FontWeight.w500),
                                                                                ),
                                                                                BlocBuilder(
                                                                                  bloc: detailPageBloc,
                                                                                  builder: (context, DetailPageState detailState) {
                                                                                    return Text(
                                                                                      listSort[detailState.code - 1],
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(fontSize: 12, fontFamily: "Ralway", fontWeight: FontWeight.w500),
                                                                                    );
                                                                                  },
                                                                                )
                                                                              ],
                                                                            ),
                                                                            flex:
                                                                                9,
                                                                          ),
                                                                          Icon(
                                                                            Icons.arrow_drop_down,
                                                                          )
                                                                        ],
                                                                      )),
                                                                ),
                                                                flex: 2,
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    )),
                                              ),
                                            ),
                                          ],
                                  body: Stack(
                                    children: <Widget>[
                                      Container(
                                          color: Colors.white,
                                          child: new EasyRefresh(
                                            key: _easyRefreshKey,
                                            refreshHeader: ConnectorHeader(
                                                key: _connectorHeaderKey,
                                                header: DeliveryHeader(
                                                  key: _headerKey,
                                                  backgroundColor:
                                                      colorBackground,
                                                )),
                                            refreshFooter: ConnectorFooter(
                                                key: _connectorFooterKeyGrid,
                                                footer: ClassicsFooter(
                                                  key: _footerKeyGrid,
                                                )),
                                            outerController:
                                                _hideButtonController,
                                            child: CustomScrollView(
                                              controller: _hideButtonController,
                                              slivers: <Widget>[
                                                SliverList(
                                                  delegate:
                                                      SliverChildListDelegate(<
                                                          Widget>[
                                                    DeliveryHeader(
                                                        key: _headerKey,
                                                        backgroundColor:
                                                            colorBackground)
                                                  ]),
                                                ),
                                                SliverList(
                                                  delegate:
                                                      SliverChildListDelegate(<
                                                          Widget>[
                                                    detailstate.indexChildCategory ==
                                                            0
                                                        ? BlocBuilder(
                                                            bloc: loadingBloc,
                                                            builder: (context,
                                                                LoadingState
                                                                    loadingState) {
                                                              return BlocBuilder(
                                                                bloc: apiBloc,
                                                                builder: (context,
                                                                    ApiState
                                                                        state) {
                                                                  return state.listMenu
                                                                              .isEmpty ||
                                                                          loadingState
                                                                              .loadingDetail
                                                                      ? Container(
                                                                          color:
                                                                              colorBackground,
                                                                          child:
                                                                              ShimmerChildMenu())
                                                                      : HeaderDetail();
                                                                },
                                                              );
                                                            },
                                                          )
                                                        : Container(),
                                                    BlocBuilder(
                                                      bloc: loadingBloc,
                                                      builder: (context,
                                                          LoadingState
                                                              loadingState) {
                                                        return BlocBuilder(
                                                          bloc: listProductBloc,
                                                          builder: (context,
                                                              ListProductState
                                                                  state) {
                                                            return loadingState
                                                                    .loadingDetail
                                                                ? Container(
                                                                    color: Colors
                                                                        .white,
                                                                    child:
                                                                        ShimmerPost(),
                                                                  )
                                                                : state.listProduct
                                                                        .isEmpty
                                                                    ? Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height: MediaQuery.of(context).size.height -
                                                                            200,
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: <
                                                                              Widget>[
                                                                            Icon(
                                                                              const IconData(0xe900, fontFamily: 'box'),
                                                                              size: 150,
                                                                            ),
                                                                            Container(
                                                                              margin: EdgeInsets.only(top: 16.0),
                                                                              child: Text(
                                                                                "Không có sản phẩm nào",
                                                                                style: TextStyle(
                                                                                  color: colorInactive,
                                                                                  fontSize: 12,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              child: Text(
                                                                                "Chúc bạn một ngày vui vẻ!",
                                                                                style: TextStyle(
                                                                                  color: colorInactive,
                                                                                  fontSize: 12,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                2.0),
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            ListPost());
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ]),
                                                ),
                                                BlocBuilder(
                                                  bloc: listProductBloc,
                                                  builder: (context,
                                                      ListProductState state) {
                                                    return state.listProduct
                                                        .isEmpty
                                                    ? SliverList(
                                                      delegate:
                                                      SliverChildListDelegate(<
                                                          Widget>[
                                                      ]),
                                                    )
                                                    : SliverList(
                                                      delegate:
                                                          SliverChildListDelegate(<
                                                              Widget>[
                                                        ClassicsFooter(
                                                          key: _footerKeyGrid,
                                                          loadHeight: 50.0,
                                                        )
                                                      ]),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            onRefresh: () async {
                                              if (await Helper().check()) {
                                                loadingBloc
                                                    .changeLoadingDetail(true);
                                                _onDefault();
                                                await new Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  if (detailstate
                                                          .indexChildCategory ==
                                                      0) {
                                                    fetchProductOfMenu(
                                                        listProductBloc,
                                                        loadingBloc,
                                                        apiBloc
                                                            .currentState
                                                            .listMenu[detailstate
                                                                .indexCategory]
                                                            .id,
                                                        detailstate.code
                                                            .toString(),
                                                        detailstate.min
                                                            .toString(),
                                                        detailstate.max
                                                            .toString(),
                                                        "1",
                                                        "10",
                                                        address);
                                                  } else {
                                                    fetchProductOfChildMenu(
                                                        listProductBloc,
                                                        loadingBloc,
                                                        apiBloc
                                                            .currentState
                                                            .listMenu[detailstate
                                                                .indexCategory]
                                                            .listChildMenu[
                                                                detailstate
                                                                    .indexChildCategory]
                                                            .id,
                                                        detailstate.code
                                                            .toString(),
                                                        detailstate.min
                                                            .toString(),
                                                        detailstate.max
                                                            .toString(),
                                                        "1",
                                                        "10",
                                                        address);
                                                  }
                                                });
                                              } else {
                                                new Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  Toast.show(
                                                      "Vui lòng kiểm tra mạng!",
                                                      context,
                                                      gravity: Toast.CENTER,
                                                      backgroundColor:
                                                          Colors.black87);
                                                });
                                              }
                                            },
                                            loadMore: () async {
                                              if (await Helper().check()) {
                                                if (listProductBloc.currentState
                                                        .listProduct.length ==
                                                    loadmoreState.end) {
                                                  loadMoreBloc.changeLoadMore(
                                                      loadmoreState.begin + 10,
                                                      loadmoreState.end + 10);
                                                  if (detailstate
                                                          .indexChildCategory ==
                                                      0) {
                                                    await fetchProductOfMenu(
                                                        listProductBloc,
                                                        loadingBloc,
                                                        apiBloc
                                                            .currentState
                                                            .listMenu[detailstate
                                                                .indexCategory]
                                                            .id,
                                                        detailstate.code
                                                            .toString(),
                                                        detailstate.min
                                                            .toString(),
                                                        detailstate.max
                                                            .toString(),
                                                        (loadmoreState.begin +
                                                                10)
                                                            .toString(),
                                                        (loadmoreState.end + 10)
                                                            .toString(),
                                                        address);
                                                  } else {
                                                    await fetchProductOfChildMenu(
                                                        listProductBloc,
                                                        loadingBloc,
                                                        apiBloc
                                                            .currentState
                                                            .listMenu[detailstate
                                                                .indexCategory]
                                                            .listChildMenu[
                                                                detailstate
                                                                    .indexChildCategory]
                                                            .id,
                                                        detailstate.code
                                                            .toString(),
                                                        detailstate.min
                                                            .toString(),
                                                        detailstate.max
                                                            .toString(),
                                                        (loadmoreState.begin +
                                                                10)
                                                            .toString(),
                                                        (loadmoreState.end + 10)
                                                            .toString(),
                                                        address);
                                                  }
                                                  _footerKeyGrid.currentState
                                                      .onLoadEnd();
                                                } else {
                                                  await new Future.delayed(
                                                      const Duration(
                                                          seconds: 1),
                                                      () {});
                                                  _footerKeyGrid.currentState
                                                      .onNoMore();
                                                  _footerKeyGrid.currentState
                                                      .onLoadClose();
                                                }
                                              } else {
                                                new Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  Toast.show(
                                                      "Vui lòng kiểm tra mạng!",
                                                      context,
                                                      gravity: Toast.CENTER,
                                                      backgroundColor:
                                                          Colors.black87);
                                                });
                                              }
                                            },
                                          )),
                                      Visibility(
                                          visible: isSearch ? true : false,
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: (!_hideButtonController
                                                              .hasClients ||
                                                          _hideButtonController
                                                                  .positions
                                                                  .length >
                                                              1)
                                                      ? 0
                                                      : _hideButtonController
                                                                  .position
                                                                  .pixels >=
                                                              141
                                                          ? 141
                                                          : _hideButtonController
                                                              .position.pixels),
                                              child: SearchPage())),
                                    ],
                                  ))),
                          type: MaterialType.transparency));
                },
              );
            },
          )),
    );
  }

  Future<bool> _onBackPressed() {
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    if (isSearch) {
      changeDetail();
    } else {
      loadingBloc.changeLoadingDetail(true);
      functionBloc.onBackPressed(_callBack);
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => child.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
