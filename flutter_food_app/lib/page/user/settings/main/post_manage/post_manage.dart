import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/load_more_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/post_manage_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/load_more_state.dart';
import 'package:flutter_food_app/common/state/loading_state.dart';
import 'package:flutter_food_app/common/state/post_manage_state.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_post.dart';
import 'package:flutter_food_app/page/user/settings/main/post_manage/filter/common/filter.dart';
import 'package:flutter_food_app/page/user/settings/main/post_manage/filter/location/filter.dart';
import 'package:flutter_food_app/page/user/settings/main/post_manage/search/search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';
import 'list_post.dart';
import 'package:flutter_food_app/const/color_const.dart';

class PostManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostManagementState();
}

class PostManagementState extends State<PostManage> {
  bool isSearch = false;
  ScrollController _hideButtonController;
  FunctionBloc functionBloc;
  final myController = TextEditingController();
  PostManageBloc postManageBloc;
  ApiBloc apiBloc;
  LoadingBloc loadingBloc;
  final loadMoreBloc = LoadMoreBloc();
  FocusScopeNode _focusA;
  FocusScopeNode _focusB;
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
  ListSearchProductBloc listSearchPostBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusA = FocusScopeNode();
    _focusB = FocusScopeNode();
    BlocProvider.of<FunctionBloc>(context).isLoading(_isLoading);
    postManageBloc = BlocProvider.of<PostManageBloc>(context);
    listSearchPostBloc = BlocProvider.of<ListSearchProductBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    loadingBloc.changeLoadingPostManage(true);
    _hideButtonController = new ScrollController();
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    User user = apiBloc.currentState.mainUser;
    user.listProducts = null;
    apiBloc.changeMainUser(user);
    if (postManageBloc.currentState.indexCategory == 0) {
      fetchProductOfUser(
          apiBloc,
          loadingBloc,
          apiBloc.currentState.mainUser.id,
          postManageBloc.currentState.code.toString(),
          postManageBloc.currentState.min.toString(),
          postManageBloc.currentState.max.toString(),
          "1",
          "10");
    } else {
      if (postManageBloc.currentState.indexChildCategory == 0) {
        fetchProductOfMenuOfUser(
            apiBloc,
            loadingBloc,
            apiBloc.currentState.mainUser.id,
            apiBloc.currentState
                .listMenu[postManageBloc.currentState.indexCategory].id,
            postManageBloc.currentState.code.toString(),
            postManageBloc.currentState.min.toString(),
            postManageBloc.currentState.max.toString(),
            "1",
            "10");
      } else {
        fetchProductOfChildMenuOfUser(
            apiBloc,
            loadingBloc,
            apiBloc.currentState.mainUser.id,
            apiBloc
                .currentState
                .listMenu[postManageBloc.currentState.indexCategory]
                .listChildMenu[postManageBloc.currentState.indexChildCategory]
                .id,
            postManageBloc.currentState.code.toString(),
            postManageBloc.currentState.min.toString(),
            postManageBloc.currentState.max.toString(),
            "1",
            "10");
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    _hideButtonController.dispose();
    loadMoreBloc.dispose();
    _focusA.detach();
    _focusB.detach();
    super.dispose();
  }

  _isLoading() {
    _onDefault();
    _hideButtonController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void changeHome() {
    setState(() {
      isSearch = false;
      myController.clear();
    });
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
    BlocProvider.of<SearchBloc>(context).changePage();
    listSearchPostBloc.changeListSearchProduct(new List<Product>());
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      elevation: 0.0,
      brightness: Brightness.light,
      title: new Text(
        "Quản lý bài viết",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
    );
  }

  _onDefault() {
    User user = apiBloc.currentState.mainUser;
    user.listProducts = null;
    apiBloc.changeMainUser(user);
    loadMoreBloc.changeLoadMore(1, 10);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProviderTree(
        blocProviders: [
          BlocProvider<LoadMoreBloc>(
            bloc: loadMoreBloc,
          ),
        ],
        child: BlocBuilder(
          bloc: apiBloc,
          builder: (context, ApiState state) {
            return BlocBuilder(
              bloc: loadMoreBloc,
              builder: (context, LoadMoreState loadmoreState) {
                return BlocBuilder(
                  bloc: postManageBloc,
                  builder: (context, PostManageState postState) {
                    return WillPopScope(
                        child: Container(
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
                                              pinned: isSearch ? true : false,
                                              floating: isSearch ? false : true,
                                              snap: isSearch ? false : true,
                                              expandedHeight: 97,
                                              bottom: PreferredSize(
                                                preferredSize:
                                                    Size.fromHeight(41),
                                                child: Column(
                                                  children: <Widget>[
                                                    buildAppBar(context),
                                                    Stack(
                                                      children: <Widget>[
                                                        FocusScope(
                                                            node: _focusA,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                        context)
                                                                    .setFirstFocus(
                                                                        _focusB);
                                                                BlocProvider.of<
                                                                            BottomBarBloc>(
                                                                        context)
                                                                    .changeVisible(
                                                                        false);
                                                                BlocProvider.of<
                                                                            SearchBloc>(
                                                                        context)
                                                                    .changePage();
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
                                                                                "Tìm kiếm bài viết",
                                                                                style: TextStyle(fontFamily: "Raleway", color: colorInactive, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                              ),
                                                            )),
                                                        Visibility(
                                                            visible: isSearch
                                                                ? true
                                                                : false,
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
                                                                      child: Container(
                                                                          margin: EdgeInsets.only(right: 16.0),
                                                                          padding: EdgeInsets.symmetric(vertical: 2.0),
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)), color: colorInactive.withOpacity(0.2)),
                                                                          child: FocusScope(
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
                                                                                      loadingBloc.changeLoadingSearch(true);
                                                                                      listSearchPostBloc.changeListSearchProduct(new List<Product>());
                                                                                      BlocProvider.of<SearchInputBloc>(context).searchInput(1, newValue);
                                                                                      if (postState.indexCategory == 0) {
                                                                                        searchProductsAllOfUser(listSearchPostBloc, loadingBloc, state.mainUser.id, newValue, postState.code.toString(), postState.min.toString(), postState.max.toString(), "1", "10");
                                                                                      } else {
                                                                                        if (postState.indexChildCategory == 0) {
                                                                                          searchProductsOfMenuOfUser(listSearchPostBloc, loadingBloc, state.listMenu[postState.indexCategory].id, state.mainUser.id, newValue, postState.code.toString(), postState.min.toString(), postState.max.toString(), "1", "10");
                                                                                        } else {
                                                                                          searchProductsOfChildMenuOfUser(listSearchPostBloc, loadingBloc, state.listMenu[postState.indexCategory].listChildMenu[postState.indexChildCategory].id, state.mainUser.id, newValue, postState.code.toString(), postState.min.toString(), postState.max.toString(), "1", "10");
                                                                                        }
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  style: TextStyle(fontFamily: "Ralway", fontSize: 12, color: Colors.black),
                                                                                  decoration: InputDecoration(
                                                                                    border: InputBorder.none,
                                                                                    hintText: 'Nhập tên bài viết',
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
                                                                          )),
                                                                      flex: 9,
                                                                    ),
                                                                    Expanded(
                                                                        flex: 1,
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
                                                                            changeHome();
                                                                          },
                                                                        ))
                                                                  ],
                                                                ))),
                                                      ],
                                                    )
                                                  ],
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
                                                      bloc: postManageBloc,
                                                      builder: (context,
                                                          PostManageState
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
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                FilterCategory()));
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
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                FilterCategory()));
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
                                                                                  state.indexCategory == 0 ? apiBloc.currentState.listMenu[state.indexCategory].name : apiBloc.currentState.listMenu[state.indexCategory].listChildMenu[state.indexChildCategory].name,
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
                                                                                FilterCommon(),
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
                                                                                  bloc: postManageBloc,
                                                                                  builder: (context, PostManageState postState) {
                                                                                    return Text(
                                                                                      listSort[postState.code - 1],
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
                                      BlocBuilder(
                                        bloc: postManageBloc,
                                        builder:
                                            (context, PostManageState state) {
                                          return BlocBuilder(
                                            bloc: apiBloc,
                                            builder:
                                                (context, ApiState apiState) {
                                              return Container(
                                                  color: colorBackground,
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
                                                      controller:
                                                          _hideButtonController,
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
                                                            BlocBuilder(
                                                              bloc: loadingBloc,
                                                              builder: (context,
                                                                  LoadingState
                                                                      loadingState) {
                                                                return loadingState
                                                                        .loadingPostManage
                                                                    ? Container(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            ShimmerPost(),
                                                                      )
                                                                    : apiState.mainUser.listProducts ==
                                                                            null
                                                                        ? Container(
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                MediaQuery.of(context).size.height - 200,
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: <Widget>[
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
                                                                        : ListPost();
                                                              },
                                                            ),
                                                          ]),
                                                        ),
                                                        apiState.mainUser
                                                                    .listProducts ==
                                                                null
                                                            ? SliverList(
                                                                delegate:
                                                                    SliverChildListDelegate(
                                                                        <Widget>[]),
                                                              )
                                                            : SliverList(
                                                                delegate:
                                                                    SliverChildListDelegate(<
                                                                        Widget>[
                                                                  ClassicsFooter(
                                                                    key:
                                                                        _footerKeyGrid,
                                                                    loadHeight:
                                                                        50.0,
                                                                    bgColor:
                                                                        colorBackground,
                                                                  )
                                                                ]),
                                                              )
                                                      ],
                                                    ),
                                                    onRefresh: () async {
                                                      if (await Helper()
                                                          .check()) {
                                                        _onDefault();
                                                        loadingBloc
                                                            .changeLoadingPostManage(
                                                                true);
                                                        if (postManageBloc
                                                                .currentState
                                                                .indexCategory ==
                                                            0) {
                                                          await fetchProductOfUser(
                                                              apiBloc,
                                                              loadingBloc,
                                                              apiBloc
                                                                  .currentState
                                                                  .mainUser
                                                                  .id,
                                                              state.code
                                                                  .toString(),
                                                              state.min
                                                                  .toString(),
                                                              state.max
                                                                  .toString(),
                                                              "1",
                                                              "10");
                                                        } else {
                                                          if (postManageBloc
                                                                  .currentState
                                                                  .indexChildCategory ==
                                                              0) {
                                                            fetchProductOfMenuOfUser(
                                                                apiBloc,
                                                                loadingBloc,
                                                                apiBloc
                                                                    .currentState
                                                                    .mainUser
                                                                    .id,
                                                                apiBloc
                                                                    .currentState
                                                                    .listMenu[postManageBloc
                                                                        .currentState
                                                                        .indexCategory]
                                                                    .id,
                                                                state.code
                                                                    .toString(),
                                                                state.min
                                                                    .toString(),
                                                                state.max
                                                                    .toString(),
                                                                "1",
                                                                "10");
                                                          } else {
                                                            fetchProductOfChildMenuOfUser(
                                                                apiBloc,
                                                                loadingBloc,
                                                                apiBloc
                                                                    .currentState
                                                                    .mainUser
                                                                    .id,
                                                                apiBloc
                                                                    .currentState
                                                                    .listMenu[postManageBloc
                                                                        .currentState
                                                                        .indexCategory]
                                                                    .listChildMenu[postManageBloc
                                                                        .currentState
                                                                        .indexChildCategory]
                                                                    .id,
                                                                state.code
                                                                    .toString(),
                                                                state.min
                                                                    .toString(),
                                                                state.max
                                                                    .toString(),
                                                                "1",
                                                                "10");
                                                          }
                                                        }
                                                      } else {
                                                        new Future.delayed(
                                                            const Duration(
                                                                seconds: 1),
                                                            () {
                                                          Toast.show(
                                                              "Vui lòng kiểm tra mạng!",
                                                              context,
                                                              gravity:
                                                                  Toast.CENTER,
                                                              backgroundColor:
                                                                  Colors
                                                                      .black87);
                                                        });
                                                      }
                                                    },
                                                    loadMore: apiState.mainUser
                                                                .listProducts ==
                                                            null
                                                        ? null
                                                        : () async {
                                                            if (await Helper()
                                                                .check()) {
                                                              if (apiBloc
                                                                      .currentState
                                                                      .mainUser
                                                                      .listProducts
                                                                      .length ==
                                                                  loadmoreState
                                                                      .end) {
                                                                loadMoreBloc.changeLoadMore(
                                                                    loadmoreState
                                                                            .begin +
                                                                        10,
                                                                    loadmoreState
                                                                            .end +
                                                                        10);
                                                                if (postManageBloc
                                                                        .currentState
                                                                        .indexCategory ==
                                                                    0) {
                                                                  await fetchProductOfUser(
                                                                      apiBloc,
                                                                      loadingBloc,
                                                                      apiBloc
                                                                          .currentState
                                                                          .mainUser
                                                                          .id,
                                                                      state.code
                                                                          .toString(),
                                                                      state.min
                                                                          .toString(),
                                                                      state.max
                                                                          .toString(),
                                                                      (loadmoreState.begin +
                                                                              10)
                                                                          .toString(),
                                                                      (loadmoreState.end +
                                                                              10)
                                                                          .toString());
                                                                } else {
                                                                  if (postManageBloc
                                                                          .currentState
                                                                          .indexChildCategory ==
                                                                      0) {
                                                                    fetchProductOfMenuOfUser(
                                                                        apiBloc,
                                                                        loadingBloc,
                                                                        apiBloc
                                                                            .currentState
                                                                            .mainUser
                                                                            .id,
                                                                        apiBloc
                                                                            .currentState
                                                                            .listMenu[postManageBloc
                                                                                .currentState.indexCategory]
                                                                            .id,
                                                                        state
                                                                            .code
                                                                            .toString(),
                                                                        state
                                                                            .min
                                                                            .toString(),
                                                                        state
                                                                            .max
                                                                            .toString(),
                                                                        (loadmoreState.begin +
                                                                                10)
                                                                            .toString(),
                                                                        (loadmoreState.end +
                                                                                10)
                                                                            .toString());
                                                                  } else {
                                                                    fetchProductOfChildMenuOfUser(
                                                                        apiBloc,
                                                                        loadingBloc,
                                                                        apiBloc
                                                                            .currentState
                                                                            .mainUser
                                                                            .id,
                                                                        apiBloc
                                                                            .currentState
                                                                            .listMenu[postManageBloc
                                                                                .currentState.indexCategory]
                                                                            .listChildMenu[postManageBloc
                                                                                .currentState.indexChildCategory]
                                                                            .id,
                                                                        state
                                                                            .code
                                                                            .toString(),
                                                                        state
                                                                            .min
                                                                            .toString(),
                                                                        state
                                                                            .max
                                                                            .toString(),
                                                                        (loadmoreState.begin +
                                                                                10)
                                                                            .toString(),
                                                                        (loadmoreState.end +
                                                                                10)
                                                                            .toString());
                                                                  }
                                                                }
                                                                _footerKeyGrid
                                                                    .currentState
                                                                    .onLoadEnd();
                                                              } else {
                                                                await new Future
                                                                        .delayed(
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                    () {});
                                                                _footerKeyGrid
                                                                    .currentState
                                                                    .onNoMore();
                                                                _footerKeyGrid
                                                                    .currentState
                                                                    .onLoadClose();
                                                              }
                                                            } else {
                                                              new Future
                                                                      .delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1),
                                                                  () {
                                                                Toast.show(
                                                                    "Vui lòng kiểm tra mạng!",
                                                                    context,
                                                                    gravity: Toast
                                                                        .CENTER,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .black87);
                                                              });
                                                            }
                                                          },
                                                  ));
                                            },
                                          );
                                        },
                                      ),
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
                                  ),
                                ),
                              ),
                              type: MaterialType.transparency),
                        ),
                        onWillPop: _onBackPress);
                  },
                );
              },
            );
          },
        ));
  }

  Future<bool> _onBackPress() {
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    if (isSearch) {
      changeHome();
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }
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
