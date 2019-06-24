import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/user_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/authentication/login/signin.dart';
import 'package:toast/toast.dart';
import 'noti_admin_item.dart';

class NotiAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotiAdminState();
}

class NotiAdminState extends State<NotiAdmin>
    with AutomaticKeepAliveClientMixin {
  UserBloc userBloc;
  ApiBloc apiBloc;
  LocationBloc locationBloc;
  int begin = 1;
  int end = 10;
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
  LoadingBloc loadingBloc;

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
            return !state.isLogin
                ? SigninContent()
                : EasyRefresh(
                    key: _easyRefreshKey,
                    refreshHeader: ConnectorHeader(
                        key: _connectorHeaderKey,
                        header: DeliveryHeader(key: _headerKey)),
                    refreshFooter: ConnectorFooter(
                        key: _connectorFooterKeyGrid,
                        footer: ClassicsFooter(
                          bgColor: colorBackground,
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
                          ListNotiAdmin(),
                          Container(
                            color: colorBackground.withOpacity(0),
                            height: 50,
                          )
                        ])),
                        apiState.mainUser == null
                            ? SliverList(
                                delegate: SliverChildListDelegate(<Widget>[]),
                              )
                            : apiState.mainUser.listSystemNotice == null
                                ? SliverList(
                                    delegate:
                                        SliverChildListDelegate(<Widget>[]),
                                  )
                                : SliverList(
                                    delegate: SliverChildListDelegate(<Widget>[
                                      ClassicsFooter(
                                        key: _footerKeyGrid,
                                        loadHeight: 50.0,
                                        bgColor: colorBackground,
                                      )
                                    ]),
                                  )
                      ],
                    ),
                    loadMore: apiState.mainUser == null
                        ? null
                        : apiState.mainUser.listSystemNotice == null
                            ? null
                            : () async {
                      if (await Helper().check()) {
                        if (apiState.mainUser.listSystemNotice.length ==
                            end) {
                          setState(() {
                            begin += 10;
                            end += 10;
                          });
                          await fetchSystemNotificaion(apiBloc, loadingBloc,
                              apiBloc.currentState.mainUser.id, begin.toString(), end.toString());
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
                    onRefresh: () async {
                      if (await Helper().check()) {
                        await new Future.delayed(const Duration(seconds: 1),
                            () async {
                          setState(() {
                            begin = 1;
                            end = 10;
                          });
                          if (apiState.mainUser == null) {
                            await fetchUserById(
                                apiBloc, apiBloc.currentState.mainUser.id);
                            fetchListPostUser(apiBloc, loadingBloc,
                                apiBloc.currentState.mainUser.id, 1, 10);
                            fetchRatingByUser(apiBloc,
                                apiBloc.currentState.mainUser.id, "1", "10");
                            fetchSystemNotificaion(apiBloc, loadingBloc,
                                apiBloc.currentState.mainUser.id, "1", "10");
                            fetchFollowNotificaion(apiBloc, loadingBloc, apiBloc.currentState.mainUser.id, "1", "10");
                            fetchAmountNewFollowNoti(apiBloc, apiBloc.currentState.mainUser.id);
                            fetchAmountNewSystemNoti(apiBloc, apiBloc.currentState.mainUser.id);
                          } else {
                            User user = apiState.mainUser;
                            user.listSystemNotice = null;
                            apiBloc.changeMainUser(user);
                            loadingBloc.changeLoadingSysNoti(true);
                            fetchSystemNotificaion(apiBloc, loadingBloc,
                                apiBloc.currentState.mainUser.id, "1", "10");
                            fetchAmountNewSystemNoti(apiBloc, apiBloc.currentState.mainUser.id);
                          }
                          if (apiState.cart == null) {
                            fetchCartByUserId(apiBloc, loadingBloc,
                                apiBloc.currentState.mainUser.id);
                          }
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
                            apiBloc.changeTopFav(null);
                            apiBloc.changeTopNewest(null);
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
                  );
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
