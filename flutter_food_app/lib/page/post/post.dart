import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/product_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/product_state.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_slider_post.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'slider.dart';
import 'body.dart';
import 'rating.dart';
import 'relative_post.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:toast/toast.dart';
import 'add_to_cart.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Post extends StatefulWidget {
  final String _idPost;

  Post(this._idPost);

  @override
  State<StatefulWidget> createState() => PostState();
}

class PostState extends State<Post> {
  String textInput = "";
  final myController = new TextEditingController();
  TextEditingController myControllerContent;
  UserBloc userBloc;
  FunctionBloc functionBloc;
  ApiBloc apiBloc;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshHeaderState> _connectorHeaderKey =
      new GlobalKey<RefreshHeaderState>();
  final productBloc = ProductBloc();
  bool isDelete = false;

  @override
  void initState() {
    super.initState();
    myControllerContent = TextEditingController();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    fetchProductById(productBloc, widget._idPost);
    userBloc = BlocProvider.of<UserBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    myController.addListener(_changeTextInput);
  }

  _changeTextInput() {
    setState(() {
      textInput = myController.text;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    myControllerContent.dispose();
    productBloc.dispose();
    super.dispose();
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

  _showAnotherReasonPopup() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Nội dung báo cáo"),
            content: Container(
              width: MediaQuery.of(context).size.width,
              color: colorBackground,
              child: TextField(
                controller: myControllerContent,
                textAlign: TextAlign.start,
                inputFormatters: [LengthLimitingTextInputFormatter(1000)],
                maxLines: 10,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  border: InputBorder.none,
                  hintText: 'Nhập nội dung báo cáo',
                  hintStyle: TextStyle(
                      fontFamily: "Ralway", fontSize: 14, color: colorInactive),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(color: Colors.black, fontSize: 14),
                autofocus: true,
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Hủy"),
                onPressed: () {
                  myControllerContent.clear();
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                  child: new Text(
                    "Chấp nhận",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    if (myControllerContent.text.isEmpty) {
                      Toast.show("Vui lòng nhập nội dung!", context,
                          gravity: Toast.CENTER);
                    } else {
                      _showLoading();
                      int check = await reportProductAnother(
                          apiBloc.currentState.mainUser.id,
                          productBloc.currentState.product.id,
                          myControllerContent.text);
                      if (check == 1) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Toast.show("Cảm ơn bạn đã gửi báo cáo!", context,
                            gravity: Toast.CENTER);
                      } else if (check == 0) {
                        Navigator.pop(context);
                        Toast.show("Không thể gửi báo cáo!", context,
                            gravity: Toast.CENTER);
                      } else if (check == 2) {
                        Navigator.pop(context);
                        Toast.show("Không thể báo cáo sản phẩm 2 lần!", context,
                            gravity: Toast.CENTER);
                      } else if (check == 3) {
                        Navigator.pop(context);
                        Toast.show(
                            "Không thể báo cáo sản phẩm của bạn!", context,
                            gravity: Toast.CENTER);
                      } else {
                        Navigator.pop(context);
                        Toast.show("Lỗi hệ thống", context,
                            gravity: Toast.CENTER);
                      }
                    }
                  }),
            ],
          );
        });
  }

  _showDeleteDialog(String idProduct){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
              "Cảnh báo!",
            style: TextStyle(
              fontFamily: "Ralway"
            ),
          ),
          content: new Text(
            "Bạn có chắc muốn xóa sản phẩm này không?",
            style: TextStyle(
              color: colorInactive,
              fontFamily: "Ralway"
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Hủy"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                  "Chấp nhận",
                style: TextStyle(
                  color: Colors.red
                ),
              ),
              onPressed: () async {
                BuildContext _contextDialog;
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      _contextDialog = context;
                      return SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      );
                    });
                if (await Helper().check()) {
                  int check = await deletePostByUser(idProduct);
                  if(check == 1){
                    Toast.show("Xóa bài viết thành công!", context);
                  }
                  else if(check == 0){
                    Toast.show("Xóa bài viết thất bại!", context);
                  }
                  Navigator.of(_contextDialog).pop();
                  Navigator.of(context).pop();
                } else {
                  new Future.delayed(
                      const Duration(seconds: 1), () {
                    Navigator.of(_contextDialog).pop();
                    Toast.show(
                        "Vui lòng kiểm tra mạng!", context,
                        gravity: Toast.CENTER,
                        backgroundColor: Colors.black87);
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  _showReportDialog() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 290.0,
            margin: EdgeInsets.all(15.0),
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                    )),
                ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 15.0),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              reportStrings[index],
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (await Helper().check()) {
                            if (index != 4) {
                              _showLoading();
                              int check = await reportProduct(
                                  apiBloc.currentState.mainUser.id,
                                  productBloc.currentState.product.id,
                                  (index + 1).toString());
                              if (check == 1) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Toast.show(
                                    "Cảm ơn bạn đã gửi báo cáo!", context,
                                    gravity: Toast.CENTER);
                              } else if (check == 0) {
                                Navigator.pop(context);
                                Toast.show("Không thể gửi báo cáo!", context,
                                    gravity: Toast.CENTER);
                              } else if (check == 2) {
                                Navigator.pop(context);
                                Toast.show("Không thể báo cáo sản phẩm 2 lần!",
                                    context,
                                    gravity: Toast.CENTER);
                              } else if (check == 3) {
                                Navigator.pop(context);
                                Toast.show(
                                    "Không thể báo cáo sản phẩm của bạn!",
                                    context,
                                    gravity: Toast.CENTER);
                              } else {
                                Navigator.pop(context);
                                Toast.show("Lỗi hệ thống", context,
                                    gravity: Toast.CENTER);
                              }
                            } else {
                              Navigator.pop(context);
                              _showAnotherReasonPopup();
                            }
                          } else {
                            new Future.delayed(const Duration(seconds: 1), () {
                              Toast.show("Vui lòng kiểm tra mạng!", context,
                                  gravity: Toast.CENTER,
                                  backgroundColor: Colors.black87);
                            });
                          }
                        },
                      ),
                ),
              ],
            ),
          );
        });
  }

  _showSettingSheet(ProductState state, ApiState apiState) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 125.0,
            margin: EdgeInsets.all(15.0),
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                    )),
                ListView.builder(
                  itemCount: (apiState.mainUser == null ||
                          (apiState.mainUser != null &&
                              state.product.idUser != apiState.mainUser.id))
                      ? nameListAnotherUser.length
                      : nameListMainUser.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 15.0),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              (apiState.mainUser == null ||
                                      (apiState.mainUser != null &&
                                          state.product.idUser !=
                                              apiState.mainUser.id))
                                  ? nameListAnotherUser[index]
                                  : nameListMainUser[index],
                              style: TextStyle(
                                  fontSize: 14,
                                  color: index != 1 ? Colors.blue : Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        onTap: () async {
                          switch (index) {
                            case 0:
                              {
                                try {
                                  Navigator.pop(context);
                                  await Share.share(
                                      'https://datnk15.herokuapp.com/product-detail/' +
                                          state.product.id);
                                } on PlatformException {
                                  print("Hủy!");
                                }
                              }
                              break;
                            case 1:
                              {
                                if (apiState.mainUser != null) {
                                  Navigator.pop(context);
                                  if(apiState.mainUser.id == state.product.idUser) {
                                    _showDeleteDialog(state.product.id);
                                  }
                                  else{
                                    _showReportDialog();
                                  }
                                } else {
                                  Navigator.pop(context);
                                  functionBloc.currentState.navigateToAuthen();
                                }
                              }
                              break;
                          }
                        },
                      ),
                ),
              ],
            ),
          );
        });
  }

  _showCart(Product product) async {
    if (await checkIsFavorite(apiBloc.currentState.mainUser.id, product.id) ==
        1) {
      product.isFavorite = true;
    } else {
      product.isFavorite = false;
    }
    showModalBottomSheet(
      context: context, // Also d// efault
      builder: (context) => Container(
            color: Colors.transparent,
            height: 350,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: AddToCart(product),
                ),
              ],
            ),
          ),
    );
  }

  Future<bool> _onBackPressed() {
    productBloc.changeProduct(null);
    Navigator.pop(context);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<ProductBloc>(bloc: productBloc),
      ],
      child: WillPopScope(
        child: BlocBuilder(
          bloc: productBloc,
          builder: (context, ProductState state) {
            if(state.product != null){
              if(!state.product.status){
                isDelete = true;
              }
            }
            return isDelete
                ? Scaffold(
              appBar: AppBar(
                elevation: 0.5,
                brightness: Brightness.light,
                title: Text(
                  "Sản phẩm không tồn tại",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0,
                  ),
                ),
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                centerTitle: true,
              ),
              backgroundColor: Colors.white,
              body: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
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
                        "Sản phẩm không tồn tại",
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
            )
                : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0.5,
                  brightness: Brightness.light,
                  title: Text(
                    state.product == null ? "" : state.product.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 17.0,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  centerTitle: true,
                  actions: <Widget>[
                    state.product == null
                        ? Container()
                        : userBloc.currentState.isAdmin
                        ? Container()
                        : IconButton(
                      icon: Icon(Icons.more_vert),
                      tooltip: 'Tùy chỉnh',
                      onPressed: () {
                        _showSettingSheet(
                            state, apiBloc.currentState);
                      },
                    ),
                  ],
                ),
                body: Container(
                    color: colorBackground,
                    child: EasyRefresh(
                      key: _easyRefreshKey,
                      refreshHeader: ConnectorHeader(
                          key: _connectorHeaderKey,
                          header: DeliveryHeader(key: _headerKey)),
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate(
                                <Widget>[DeliveryHeader(key: _headerKey)]),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(<Widget>[
                              state.product == null
                                  ? ShimmerSliderPost()
                                  : CarouselWithIndicator(),
                              state.product == null
                                  ? Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(
                                            bottom: 12.0,
                                            left: 15.0,
                                            right: 15.0,
                                            top: 15.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                Radius.circular(10.0),
                                                bottomRight:
                                                Radius.circular(10.0))),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 400,
                                        padding: EdgeInsets.all(16.0),
                                        margin: EdgeInsets.only(
                                            top: 5.0, bottom: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                                  : ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  PostBody(widget._idPost),
                                  CommentPost(),
                                  RelativePost(),
                                ],
                              )
                            ]),
                          ),
                        ],
                      ),
                      onRefresh: () async {
                        await new Future.delayed(const Duration(seconds: 1),
                                () {
                              fetchProductById(productBloc, widget._idPost);
                            });
                      },
                    )),
                bottomNavigationBar: state.product == null
                    ? Container(
                  height: 0,
                  width: 0,
                )
                    : BlocBuilder(
                  bloc: apiBloc,
                  builder: (context, ApiState apiState) {
                    return userBloc.currentState.isAdmin
                        ? Container(
                      height: 0,
                      width: 0,
                    )
                        : (apiState.mainUser == null ||
                        (apiState.mainUser != null &&
                            state.product.idUser !=
                                apiState.mainUser.id))
                        ? Container(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                if (userBloc
                                    .currentState.isLogin) {
                                  _showCart(state.product);
                                } else {
                                  functionBloc
                                      .onBeforeLogin(() {
                                    _showCart(state.product);
                                  });
                                  functionBloc.currentState
                                      .navigateToAuthen();
                                }
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: colorActive,
                                        width: 1.5)),
                                child: Center(
                                  child: Text(
                                    'THÊM VÀO GIỎ HÀNG',
                                    style: TextStyle(
                                        color: colorActive,
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: 12.0),
                                  ),
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: GestureDetector(
                              child: Container(
                                height: 50,
                                color: colorActive,
                                child: Center(
                                  child: Text(
                                    'GỌI ĐIỆN NGƯỜI BÁN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: 12.0),
                                  ),
                                ),
                              ),
                              onTap: () {
                                print(state.product.user.phone);
                                if (state.product.user !=
                                    null) {
                                  UrlLauncher.launch("tel://" +
                                      state.product.user.phone);
                                }
                              },
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    )
                        : Container(
                      height: 0,
                      width: 0,
                    );
                  },
                ));
          },
        ),
        onWillPop: _onBackPressed,
      ),
    );
  }
}
