import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/another_user_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/another_user_state.dart';
import 'package:flutter_food_app/page/another_user/info_item.dart';
import 'package:flutter_food_app/page/another_user/list_post.dart';
import 'package:flutter_food_app/page/another_user/list_rating.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
import 'header.dart';
import 'package:flutter_food_app/const/color_const.dart';

class InfoAnotherPage extends StatefulWidget {
  final String idUser;

  InfoAnotherPage(this.idUser);

  @override
  State<StatefulWidget> createState() => InfoAnotherPageState();
}

class InfoAnotherPageState extends State<InfoAnotherPage> with SingleTickerProviderStateMixin{
  bool isFollow = false;
  ScrollController _hideButtonController;
  int beginPost = 1;
  int endPost = 10;
  int beginRating = 1;
  int endRating = 10;
  double ratingValue = 5.0;
  final myController = new TextEditingController();
  final anotherUserBloc = AnotherUserBloc();
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
  int index = 0;
  TabController _tabController;
  ApiBloc apiBloc;
  UserBloc userBloc;
  FunctionBloc functionBloc;

  void _showBottomSheetAnotherUser(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 70.0,
            margin: EdgeInsets.all(15.0),
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15.0))
                        ),
                      ),
                    )
                ),
                GestureDetector(
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "Đánh giá người dùng",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  onTap: (){
                    if(userBloc.currentState.isLogin){
                      popupRating();
                    }
                    else{
                      functionBloc
                          .onBeforeLogin(() {
                        popupRating();
                      });
                      functionBloc.currentState
                          .navigateToAuthen();
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
  }

  void popupRating() {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  width: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Đánh giá",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: SmoothStarRating(
                            allowHalfRating: false,
                            rating: ratingValue,
                            starCount: 5,
                            size: 30,
                            color: Colors.yellow,
                            borderColor: Colors.yellow,
                            onRatingChanged: (v) {
                              setState(() {
                                ratingValue = v;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextField(
                          autofocus: true,
                          controller: myController,
                          maxLengthEnforced: true,
                          maxLength: 100,
                          decoration: InputDecoration(
                            hintText: "Nhập bình luận",
                            border: InputBorder.none,
                          ),
                          cursorColor: colorActive,
                          maxLines: 4,
                        ),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: colorActive,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32.0),
                                bottomRight: Radius.circular(32.0)),
                          ),
                          child: Text(
                            "ĐỒNG Ý",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () async {
                          if (myController.text.isEmpty) {
                            Toast.show('Vui lòng nhập nội dung!', context,
                                duration: 2);
                          } else {
                            _showLoading();
                            int check = await addRatingUser(
                              anotherUserBloc,
                                widget.idUser,
                                apiBloc.currentState.mainUser.id,
                                ratingValue.toInt().toString(),
                                myController.text
                            );
                            if(check == 0){
                              Toast.show("Lỗi hệ thống!", context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                            else if(check == 2){
                              Toast.show("Bạn đã đánh giá người dùng này!", context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                            else{
                              Toast.show('Cảm ơn bạn đã đánh giá!', context,
                                  duration: 2);
                              myController.clear();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  loadMorePost(AnotherUserState state) async {
    if (await Helper().check()) {
      if (state.user.listProductShow.length == endPost) {
        setState(() {
          beginPost += 10;
          endPost += 10;
        });
        await fetchListPostAnotherUser(anotherUserBloc, widget.idUser, beginPost, endPost);
        _footerKeyGrid.currentState.onLoadEnd();
      } else {
        await new Future.delayed(const Duration(seconds: 1), () {});
        _footerKeyGrid.currentState.onNoMore();
        _footerKeyGrid.currentState.onLoadClose();
      }
    } else {
      new Future.delayed(const Duration(seconds: 1), () {
        Toast.show("Vui lòng kiểm tra mạng!", context,
            gravity: Toast.CENTER, backgroundColor: Colors.black87);
      });
    }
  }

  loadMoreRating(AnotherUserState state) async {
    if (await Helper().check()) {
      if (state.user.listRatings.length == endRating) {
        setState(() {
          beginRating += 10;
          endRating += 10;
        });
        await fetchRatingByAnotherUser(anotherUserBloc, widget.idUser, beginRating.toString(), endRating.toString());
        _footerKeyGrid.currentState.onLoadEnd();
      } else {
        await new Future.delayed(const Duration(seconds: 1), () {});
        _footerKeyGrid.currentState.onNoMore();
        _footerKeyGrid.currentState.onLoadClose();
      }
    } else {
      new Future.delayed(const Duration(seconds: 1), () {
        Toast.show("Vui lòng kiểm tra mạng!", context,
            gravity: Toast.CENTER, backgroundColor: Colors.black87);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    userBloc = BlocProvider.of<UserBloc>(context);
    functionBloc = BlocProvider.of(context);
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        setState(() {
          index = 0;
        });
      } else if (_tabController.index == 1) {
        setState(() {
          index = 1;
        });
      } else {
        setState(() {
          index = 2;
        });
      }
    });
    (() async {
      if(await Helper().check()){
        await fetchAnotherById(anotherUserBloc, widget.idUser);
        fetchListPostAnotherUser(anotherUserBloc, widget.idUser, 1, 10);
        fetchRatingByAnotherUser(anotherUserBloc, widget.idUser, "1", "10");

      }else {
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
    })();
    _hideButtonController = new ScrollController();
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hideButtonController.dispose();
    anotherUserBloc.dispose();
    myController.dispose();
  }

  List<Widget> _fragments = [
    Container(
      padding: EdgeInsets.all(2.0),
      child: ListPost(),
    ),
    Container(
      color: Colors.white,
      child: ListRating(),
    ),
    Container(
      color: Colors.white,
      child: InfoItem(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProviderTree(
        blocProviders: [
          BlocProvider<AnotherUserBloc>(bloc: anotherUserBloc),
        ],
        child: BlocBuilder(
          bloc: anotherUserBloc,
          builder: (context, AnotherUserState state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.5,
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                title: Text(
                  state.user == null ? "" : state.user.username,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white,
                centerTitle: true,
                actions: <Widget>[
                  state.user == null || userBloc.currentState.isAdmin
                  ? Container()
                  : GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        child: Padding(
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                          padding: EdgeInsets.only(right: 10.0),
                        ),
                        onTap: () {
                          _showBottomSheetAnotherUser(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: colorBackground,
              body: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    state.user == null
                        ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      color: Colors.white,
                    )
                        : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(state.user.coverphoto),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 400,
                        child: state.user == null
                            ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.white,
                        )
                            : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height *
                                    1 /
                                    15),
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      child: Shimmer.fromColors(
                                        child: Icon(
                                          FontAwesomeIcons.handPointUp,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        baseColor: colorActive,
                                        highlightColor: Colors.orange,
                                      ),
                                      padding: EdgeInsets.only(
                                          right: 16.0, bottom: 5.0),
                                    ),
                                    Shimmer.fromColors(
                                      child: Text(
                                        "Thả tay để làm mới trang",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 17),
                                      ),
                                      baseColor: colorActive,
                                      highlightColor: Colors.orange,
                                    )
                                  ],
                                )))),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent.withOpacity(0.7),
                    ),
                    EasyRefresh(
                      key: _easyRefreshKey,
                      refreshHeader: ConnectorHeader(
                          key: _connectorHeaderKey,
                          header: DeliveryHeader(
                            key: _headerKey,
                            backgroundColor: Colors.black,
                          )),
                      refreshFooter: ConnectorFooter(
                          key: _connectorFooterKeyGrid,
                          footer: ClassicsFooter(
                            key: _footerKeyGrid,
                          )),
                      child: CustomScrollView(
                        controller: _hideButtonController,
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate(
                                <Widget>[DeliveryHeader(key: _headerKey)]),
                          ),
                          SliverList(
                              delegate: SliverChildListDelegate(<Widget>[
                                HeaderAnother(widget.idUser),
                                ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Container(
                                      height: 54,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: colorInactive,
                                                width: 0.5)),
                                      ),
                                      child: TabBar(
                                        controller: _tabController,
                                        indicatorColor: Colors.black,
                                        unselectedLabelColor: Colors.grey,
                                        labelColor: Colors.black,
                                        tabs: [
                                          Tab(
                                            child: Text(
                                              "Bài viết",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Đánh giá",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Thông tin",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: index == 2
                                          ? Colors.white
                                          : colorBackground,
                                      child: _fragments[index],
                                    ),
                                  ],
                                )
                              ])),
                          state.user != null
                              ? index == 0 || index == 1
                              ? SliverList(
                            delegate:
                            SliverChildListDelegate(<Widget>[
                              ClassicsFooter(
                                bgColor: colorBackground,
                                key: _footerKeyGrid,
                                loadHeight: 50.0,
                              )
                            ]),
                          )
                              : SliverList(
                            delegate: SliverChildListDelegate(
                                <Widget>[]),
                          )
                              : SliverList(
                            delegate:
                            SliverChildListDelegate(<Widget>[]),
                          )
                        ],
                      ),
                      onRefresh: () async {
                        if (await Helper().check()) {
                          await new Future.delayed(
                              const Duration(seconds: 1), () async {
                            setState(() {
                              beginPost = 1;
                              beginRating = 1;
                              endPost = 10;
                              endRating = 10;
                            });
                            User user = state.user;
                            user.listProductShow = null;
                            user.listRatings = null;
                            anotherUserBloc.changeAnotherUser(user);
                            fetchAnotherById(anotherUserBloc, widget.idUser);
                            fetchListPostAnotherUser(anotherUserBloc, widget.idUser, 1, 10);
                            fetchRatingByAnotherUser(anotherUserBloc, widget.idUser, "1", "10");
                          });
                        } else {
                          new Future.delayed(const Duration(seconds: 1),
                                  () {
                                Toast.show("Vui lòng kiểm tra mạng!", context,
                                    gravity: Toast.CENTER,
                                    backgroundColor: Colors.black87);
                              });
                        }
                      },
                      loadMore: state.user != null
                          ? index == 0
                          ? () {
                        loadMorePost(state);
                      }
                          : index == 1
                          ? () {
                        loadMoreRating(state);
                      }
                          : null
                          : null,
                    ),
                  ],
                ),
              )
            );
          },
        ));
  }
}
