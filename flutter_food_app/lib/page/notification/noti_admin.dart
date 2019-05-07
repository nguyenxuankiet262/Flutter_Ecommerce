import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/state/user_state.dart';
import 'package:flutter_food_app/page/authentication/login/signin.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_notification.dart';
import 'noti_admin_item.dart';

class NotiAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotiAdminState();
}

class NotiAdminState extends State<NotiAdmin>
    with AutomaticKeepAliveClientMixin {
  UserBloc userBloc;
  bool isLoading = true;
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
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        isLoading = false;
      });
    });
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
        return !state.isLogin
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
                      isLoading
                          ? ShimmerNotification()
                          : ListNotiAdmin(),
                    ]))
                  ],
                ),
                onRefresh: () async {
                  await new Future.delayed(const Duration(seconds: 1), () {});
                },
              );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
