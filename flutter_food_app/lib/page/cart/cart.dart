import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/cart.dart';
import 'package:flutter_food_app/api/model/items.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/user_state.dart';
import 'package:flutter_food_app/page/authentication/login/signin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'list_cart.dart';
import 'package:flutter_food_app/const/color_const.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  int itemCount = 1;

  UserBloc userBloc;
  ApiBloc apiBloc;
  LoadingBloc loadingBloc;
  LocationBloc locationBloc;

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshHeaderState> _connectorHeaderKey =
      new GlobalKey<RefreshHeaderState>();

  ScrollController _hideButtonController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationBloc = BlocProvider.of(context);
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
    userBloc = BlocProvider.of<UserBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hideButtonController.dispose();
  }

  void _showDialogPost(ApiState apiState) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.all(0.0),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/images/gifs/relax.gif',
                        fit: BoxFit.fill,
                      ),
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                    ),
                    height: 200,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    height: 40,
                    child: Center(
                      child: Text(
                        "Thông báo",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: "Ralway",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0, right: 20, left: 20),
                    child: Text(
                      'Hãy kiểm tra kĩ càng trước khi đặt hàng!.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: colorInactive,
                          fontSize: 14,
                          fontFamily: "Ralway"),
                    ),
                  ),
                  Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 25.0, top: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      "HỦY",
                                      style: TextStyle(
                                          color: colorInactive,
                                          fontSize: 14,
                                          fontFamily: "Ralway",
                                        fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.only(right: 8),
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff66CEFF),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "ĐỒNG Ý",
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: "Ralway"
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              onTap: () async {
                                Navigator.pop(context);
                                _showLoading(apiState);
                                //_onSuccess();
                              },
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  void _showLoading(ApiState apiState) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _onAddOrder(apiState, context);
          return SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
  }

  _onAddOrder(ApiState apiState, BuildContext context) async {
    Cart cart = apiState.cart;
    while (true) {
      List<Items> items = new List<Items>();
      String idSeller = cart.products[0].idUser;
      for (int i = 0; i < cart.products.length; i++) {
        if (idSeller == cart.products[i].idUser) {
          items.add(cart.items[i]);
          cart.items.removeAt(i);
          cart.products.removeAt(i);
        }
      }
      await addOrder(apiBloc, idSeller, items, apiState.mainUser.id);
      if (cart.items.isEmpty) {
        break;
      }
    }
    User user = apiState.mainUser;
    user.badge.buy++;
    apiBloc.changeMainUser(user);
    Navigator.pop(context);
    Toast.show("Đặt hàng thành công", context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return BlocBuilder(
      bloc: userBloc,
      builder: (context, UserState state) {
        return BlocBuilder(
          bloc: apiBloc,
          builder: (context, ApiState apiState) {
            return Scaffold(
                appBar: AppBar(
                  elevation: 0.5,
                  brightness: Brightness.light,
                  title: Text(
                    'Giỏ hàng',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  actions: <Widget>[
                    !state.isLogin
                        ? Container()
                        : apiState.cart == null ||
                                apiState.cart.products.isEmpty
                            ? Container()
                            : new Center(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: GestureDetector(
                                    child: Text(
                                      'ĐẶT HÀNG',
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                          color: itemCount > 0
                                              ? colorActive
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                    onTap: () {
                                      _showDialogPost(apiState);
                                    },
                                  ),
                                ),
                              ),
                  ],
                ),
                body: !state.isLogin
                    ? SigninContent()
                    : EasyRefresh(
                        key: _easyRefreshKey,
                        refreshHeader: ConnectorHeader(
                            key: _connectorHeaderKey,
                            header: DeliveryHeader(key: _headerKey)),
                        child: CustomScrollView(
                          controller: _hideButtonController,
                          slivers: <Widget>[
                            SliverList(
                              delegate: SliverChildListDelegate(
                                  <Widget>[DeliveryHeader(key: _headerKey)]),
                            ),
                            SliverList(
                                delegate: SliverChildListDelegate(<Widget>[
                              Container(
                                child: ListCart(),
                                color: colorBackground.withOpacity(0),
                              ),
                              Container(
                                color: colorBackground.withOpacity(0),
                                height: 150,
                              )
                            ]))
                          ],
                        ),
                        onRefresh: () async {
                          if (await Helper().check()) {
                            await new Future.delayed(const Duration(seconds: 1),
                                () async {
                              if (apiState.mainUser == null) {
                                await fetchUserById(
                                    apiBloc, apiBloc.currentState.mainUser.id);
                                fetchListPostUser(apiBloc, loadingBloc,
                                    apiBloc.currentState.mainUser.id, 1, 10);
                                fetchRatingByUser(
                                    apiBloc,
                                    apiBloc.currentState.mainUser.id,
                                    "1",
                                    "10");
                                fetchCountNewOrder(
                                    apiBloc, apiBloc.currentState.mainUser.id);
                                fetchSystemNotificaion(
                                    apiBloc,
                                    loadingBloc,
                                    apiBloc.currentState.mainUser.id,
                                    "1",
                                    "10");
                                fetchAmountNewSystemNoti(apiBloc, apiBloc.currentState.mainUser.id);
                                fetchFollowNotificaion(
                                    apiBloc,
                                    loadingBloc,
                                    apiBloc.currentState.mainUser.id,
                                    "1",
                                    "10");
                                fetchAmountNewFollowNoti(apiBloc, apiBloc.currentState.mainUser.id);
                              }
                              fetchCartByUserId(apiBloc, loadingBloc,
                                  apiBloc.currentState.mainUser.id);
                              if (apiState.listMenu.isEmpty) {
                                fetchBanner(apiBloc);
                                String address = " ";
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
                                apiBloc.changeTopNewest(null);
                                apiBloc.changeTopFav(null);
                                fetchTopTenNewestProduct(apiBloc, address);
                                fetchTopTenFavProduct(apiBloc, address);
                                fetchMenus(apiBloc);
                              }
                              BlocProvider.of<BottomBarBloc>(context)
                                  .changeVisible(true);
                            });
                          } else {
                            new Future.delayed(const Duration(seconds: 1), () {
                              Toast.show("Vui lòng kiểm tra mạng!", context,
                                  gravity: Toast.CENTER,
                                  backgroundColor: Colors.black87);
                            });
                          }
                        },
                      ));
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
