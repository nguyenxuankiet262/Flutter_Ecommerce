import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/location_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'body.dart';
import 'package:flutter_food_app/page/search/search.dart';

class MyHomePage extends StatefulWidget {
  final Function navigateToPost, navigateToFilter, navigateToSearch, setFocus;

  MyHomePage(this.navigateToPost, this.navigateToFilter, this.navigateToSearch, this.setFocus);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  bool complete = false;
  bool isSearch = false;
  final myController = TextEditingController();
  ApiBloc apiBloc;
  FunctionBloc functionBloc;
  ListSearchProductBloc listSearchProductBloc;
  LocationBloc locationBloc;
  LoadingBloc loadingBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    listSearchProductBloc = BlocProvider.of<ListSearchProductBloc>(context);
    locationBloc = BlocProvider.of<LocationBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    functionBloc.onBackPressed(_onBackPressed);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    apiBloc.dispose();
    listSearchProductBloc.dispose();
    super.dispose();
  }

  void navigateToPost() {
    this.widget.navigateToPost();
  }

  void navigateToFilter() {
    this.widget.navigateToFilter();
  }

  void navigateToSearch() {
    this.widget.navigateToSearch();
  }

  void changeHome() {
    isSearch = false;
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
    listSearchProductBloc.changeListSearchProduct(new List<Product>());
    myController.clear();
    BlocProvider.of<SearchBloc>(context).changePage();
  }

  Future<bool> _onBackPressed() {
    if (isSearch) {
      setState(() {
        changeHome();
      });
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(111.0), // here the desired height
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    AppBar(
                      brightness: Brightness.light,
                      centerTitle: true,
                      title: Container(
                        child: new Text(
                          'Anzi',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      iconTheme: IconThemeData(
                        color: Colors.black, //change your color here
                      ),
                      backgroundColor: Colors.white,
                    ),
                    Container(
                      height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
                      padding: EdgeInsets.only(left: 16.0, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 56,
                            width: 70,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8.0),
                            child: GestureDetector(
                                onTap: () {
                                  navigateToSearch();
                                },
                                child: Container(
                                  color: Colors.white,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: 3.0,
                                              bottom: 3.0,
                                              right: 10.0,
                                              left: 10.0),
                                          height: 31,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0)),
                                              border: Border.all(
                                                  color: colorActive, width: 0.5)),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(right: 5.0),
                                                child: Icon(
                                                  Icons.location_on,
                                                  color: colorActive,
                                                  size: 15,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Chọn khu vực",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontFamily: "Ralway"),
                                                  ),
                                                  BlocBuilder(
                                                      bloc: BlocProvider.of<LocationBloc>(
                                                          context),
                                                      builder:
                                                          (context, LocationState state) {
                                                        return Container(
                                                            width: 70,
                                                            child: Text(
                                                              state.indexProvince == 0
                                                                  ? state.nameCities[
                                                              state.indexCity]
                                                                  : state.nameProvinces[
                                                              state.indexCity]
                                                              [state
                                                                  .indexProvince],
                                                              style: TextStyle(
                                                                  color: colorActive,
                                                                  fontSize: 10,
                                                                  fontFamily: "Ralway"),
                                                              overflow:
                                                              TextOverflow.ellipsis,
                                                              maxLines: 1,
                                                            ));
                                                      }),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ))
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
                              child: BlocBuilder(
                                bloc: locationBloc,
                                builder: (context, LocationState locationState){
                                  return Container(
                                      margin: EdgeInsets.only(left: 15.0),
                                      child: TextField(
                                        autofocus: true,
                                        controller: myController,
                                        textInputAction: TextInputAction.search,
                                        onSubmitted: (newValue) {
                                          setState(() {
                                            functionBloc.currentState.onRefreshLoadMore();
                                            BlocProvider.of<SearchInputBloc>(
                                                context)
                                                .searchInput(1, newValue);
                                            String address = "";
                                            if (locationState.indexCity != 0) {
                                              if (locationState.indexProvince != 0) {
                                                address = locationState
                                                    .nameProvinces[locationState.indexCity]
                                                [locationState.indexProvince] +
                                                    ", " +
                                                    locationState.nameCities[locationState.indexCity];
                                              } else {
                                                address = locationState.nameCities[locationState.indexCity];
                                              }
                                            }
                                            loadingBloc.changeLoadingSearch(true);
                                            searchProductsAll(listSearchProductBloc, loadingBloc, newValue, "1", "10", address);
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
                                          suffixIcon: myController.text.isEmpty
                                              ? null
                                              : GestureDetector(
                                            onTap: () {
                                              setState(() {
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
                                      ));
                                },
                              )
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
                        widget.setFocus();
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
        backgroundColor: colorBackground,
        body: Stack(
          children: <Widget>[
            Container(
              color: colorBackground,
              child:
              BodyContent(this.navigateToPost, this.navigateToFilter),
            ),
            Visibility(
              visible: isSearch ? true: false,
              child: SearchPage(),
            )
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
