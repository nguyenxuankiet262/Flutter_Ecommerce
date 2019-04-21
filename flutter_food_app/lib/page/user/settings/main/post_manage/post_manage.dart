import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/address_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/address_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'category.dart';
import 'search/search.dart';
import 'package:flutter_food_app/const/color_const.dart';

class PostManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostManageState();
}

class PostManageState extends State<PostManage> {
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

  Future<bool> _backpress() async {
    if (isSearch) {
      setState(() {
        changeHome();
      });
      //print("Search true");
    } else {
      if (BlocProvider.of<AddressBloc>(context).currentState.index == 2) {
        BlocProvider.of<AddressBloc>(context).currentState.backpressDetail();
        //print("Search false + back2");
      } else if (BlocProvider.of<AddressBloc>(context).currentState.index ==
          1) {
        BlocProvider.of<AddressBloc>(context).currentState.backpressChild();
        //print("Search false + back1");
      } else {
        Navigator.pop(context, true);
        //print("Search false + back0");
      }
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          _backpress();
        },
        child: BlocBuilder(
            bloc: BlocProvider.of<AddressBloc>(context),
            builder: (context, AddressState state) {
              return new Scaffold(
                resizeToAvoidBottomPadding: false,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(111.0),
                    // here the desired height
                    child: Column(
                      children: <Widget>[
                        AppBar(
                          centerTitle: state.address.isNotEmpty ? false : true,
                          brightness: Brightness.light,
                          title: state.address.isNotEmpty
                              ? Container(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  EdgeInsets.only(top: 8, bottom: 2),
                                  child: new Text(
                                    "Quản lý bài viết",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 17),
                                  ),
                                ),
                                Text(
                                  state.address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: colorInactive,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )
                              : Text(
                            'Quản lý bài viết',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 24,
                            ),
                            onPressed: () {
                              _backpress();
                            },
                          ),
                          backgroundColor: Colors.white,
                          iconTheme: IconThemeData(
                            color: Colors.black, //change your color here
                          ),
                        ),
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
                                            hintText: 'Nhập tên bài viết',
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
                                                  myController
                                                      .clear();
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
                                                  fontWeight:
                                                  FontWeight.w600,
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
                            BlocProvider.of<SearchBloc>(context)
                                .changePage();
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
                                    color:
                                    colorInactive.withOpacity(0.2)),
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
                                        "Tìm kiếm bài viết",
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
                  body: Stack(children: <Widget>[
                    SearchPage(),
                    Visibility(
                      maintainState: true,
                      visible: isSearch ? false : true,
                      child: CategoryRadio(),
                    )
                  ]));
            }));
  }
}
