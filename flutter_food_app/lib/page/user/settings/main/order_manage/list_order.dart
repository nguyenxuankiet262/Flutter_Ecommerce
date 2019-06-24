import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_order.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toast/toast.dart';
import 'order_item.dart';

class ListOrder extends StatefulWidget {
  final int index;
  final bool isSellOrder;

  ListOrder(this.index, this.isSellOrder);

  @override
  State<StatefulWidget> createState() => ListOrderState();
}

class ListOrderState extends State<ListOrder>
    with AutomaticKeepAliveClientMixin {
  int begin = 1;
  int end = 10;
  bool isLoading = true;
  ApiBloc apiBloc;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    User user = apiBloc.currentState.mainUser;
    if (widget.index == 0) {
      user.listNewOrder = null;
    } else if (widget.index == 1) {
      user.listSuccessOrder = null;
    } else {
      user.listCancelOrder = null;
    }
    apiBloc.changeMainUser(user);
    (() async {
      if (await Helper().check()) {
        await fetchOrderById(apiBloc, apiBloc.currentState.mainUser.id,
            widget.index, widget.isSellOrder, "1", "10");
        setState(() {
          isLoading = false;
        });
      } else {
        new Future.delayed(const Duration(seconds: 1), () {
          Toast.show("Vui lòng kiểm tra mạng!", context,
              gravity: Toast.CENTER, backgroundColor: Colors.black87);
        });
      }
    })();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    User user = apiBloc.currentState.mainUser;
    user.listCancelOrder = null;
    user.listSuccessOrder = null;
    user.listNewOrder = null;
    apiBloc.changeMainUser(user);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return EasyRefresh(
          key: _easyRefreshKey,
          refreshHeader: ConnectorHeader(
              key: _connectorHeaderKey,
              header: DeliveryHeader(key: _headerKey)),
          refreshFooter: ConnectorFooter(
              key: _connectorFooterKeyGrid,
              footer: ClassicsFooter(
                key: _footerKeyGrid,
              )),
          child: CustomScrollView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                    <Widget>[DeliveryHeader(key: _headerKey)]),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                isLoading
                    ? ShimmerOrder()
                    : (widget.index == 0 &&
                                state.mainUser.listNewOrder == null) ||
                            (widget.index == 1 &&
                                state.mainUser.listSuccessOrder == null) ||
                            (widget.index == 2 &&
                                state.mainUser.listCancelOrder == null)
                        ? Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 2 / 3,
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
                        : (widget.index == 0 &&
                                    state.mainUser.listNewOrder.isEmpty) ||
                                (widget.index == 1 &&
                                    state.mainUser.listSuccessOrder.isEmpty) ||
                                (widget.index == 2 &&
                                    state.mainUser.listCancelOrder.isEmpty)
                            ? Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 2 / 3,
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
                                color: colorBackground,
                                child: StaggeredGridView.countBuilder(
                                    padding: EdgeInsets.only(top: 5),
                                    crossAxisCount: 2,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: widget.index == 0
                                        ? state.mainUser.listNewOrder.length
                                        : widget.index == 1
                                            ? state.mainUser.listSuccessOrder
                                                .length
                                            : state.mainUser.listCancelOrder
                                                .length,
                                    itemBuilder: (BuildContext context, int index) => OrderItem(
                                        widget.index == 0
                                            ? state.mainUser.listNewOrder[index]
                                            : widget.index == 1
                                                ? state.mainUser
                                                    .listSuccessOrder[index]
                                                : state.mainUser
                                                    .listCancelOrder[index],
                                        widget.index,
                                        widget.isSellOrder),
                                    staggeredTileBuilder: (int index) =>
                                        new StaggeredTile.fit(2)),
                              )
              ])),
              (widget.index == 0 && state.mainUser.listNewOrder == null) ||
                      (widget.index == 1 &&
                          state.mainUser.listSuccessOrder == null) ||
                      (widget.index == 2 &&
                          state.mainUser.listCancelOrder == null)
                  ? SliverList(
                      delegate: SliverChildListDelegate(<Widget>[]),
                    )
                  : (widget.index == 0 &&
                              state.mainUser.listNewOrder.isEmpty) ||
                          (widget.index == 1 &&
                              state.mainUser.listSuccessOrder.isEmpty) ||
                          (widget.index == 2 &&
                              state.mainUser.listCancelOrder.isEmpty)
                      ? SliverList(
                          delegate: SliverChildListDelegate(<Widget>[]),
                        )
                      : SliverList(
                          delegate: SliverChildListDelegate(<Widget>[
                            ClassicsFooter(
                              key: _footerKeyGrid,
                              loadHeight: 50.0,
                            )
                          ]),
                        )
            ],
          ),
          onRefresh: () async {
            await new Future.delayed(const Duration(seconds: 1), () async {
              if (await Helper().check()) {
                setState(() {
                  isLoading = true;
                  begin = 1;
                  end = 10;
                });
                User user = apiBloc.currentState.mainUser;
                if (widget.index == 0) {
                  user.listNewOrder = null;
                } else if (widget.index == 1) {
                  user.listSuccessOrder = null;
                } else {
                  user.listCancelOrder = null;
                }
                apiBloc.changeMainUser(user);
                await fetchOrderById(apiBloc, apiBloc.currentState.mainUser.id,
                    widget.index, widget.isSellOrder, "1", "10");
                setState(() {
                  isLoading = false;
                });
              } else {
                new Future.delayed(const Duration(seconds: 1), () {
                  Toast.show("Vui lòng kiểm tra mạng!", context,
                      gravity: Toast.CENTER, backgroundColor: Colors.black87);
                });
              }
            });
          },
          loadMore: (widget.index == 0 &&
                      state.mainUser.listNewOrder == null) ||
                  (widget.index == 1 &&
                      state.mainUser.listSuccessOrder == null) ||
                  (widget.index == 2 && state.mainUser.listSuccessOrder == null)
              ? null
              : () async {
                  if (await Helper().check()) {
                    if (widget.index == 0
                        ? state.mainUser.listNewOrder.length == end
                        : widget.index == 1
                            ? state.mainUser.listSuccessOrder.length == end
                            : state.mainUser.listCancelOrder.length == end) {
                      setState(() {
                        begin += 10;
                        end += 10;
                      });
                      await fetchOrderById(
                          apiBloc,
                          apiBloc.currentState.mainUser.id,
                          widget.index,
                          widget.isSellOrder,
                          begin.toString(),
                          end.toString());
                      _footerKeyGrid.currentState.onLoadEnd();
                    } else {
                      await new Future.delayed(
                          const Duration(seconds: 1), () {});
                      _footerKeyGrid.currentState.onNoMore();
                      _footerKeyGrid.currentState.onLoadClose();
                    }
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
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
