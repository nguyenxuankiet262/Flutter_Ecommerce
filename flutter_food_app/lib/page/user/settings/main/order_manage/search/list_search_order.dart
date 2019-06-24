import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/order.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_order_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/list_search_order_state.dart';
import 'package:flutter_food_app/common/state/loading_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_order.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toast/toast.dart';
import 'search_order_item.dart';

class ListSearchOrder extends StatefulWidget {
  final int index;
  final bool isSellOrder;
  final ScrollController scrollController;

  ListSearchOrder(
      {Key key, this.index, this.isSellOrder, this.scrollController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ListSearchOrderPageState();
}

class ListSearchOrderPageState extends State<ListSearchOrder>
    with AutomaticKeepAliveClientMixin {
  int begin = 1;
  int end = 10;
  bool isLoading = true;
  final listSearchOrderBloc = ListSearchOrderBloc();
  LoadingBloc loadingBloc;
  ApiBloc apiBloc;
  FunctionBloc functionBloc;
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

  void onRefreshListSearchOrder() {
    listSearchOrderBloc.changeListSearchOrder(new List<Order>());
    setState(() {
      isLoading = true;
    });
    (() async {
      if (await Helper().check()) {
        await searchOrder(
            listSearchOrderBloc,
            loadingBloc,
            apiBloc.currentState.mainUser.id,
            BlocProvider.of<SearchInputBloc>(context).currentState.searchInput,
            widget.isSellOrder ? "2" : "1",
            widget.index == 0 ? "2" : widget.index == 1 ? "1" : "0",
            "1",
            "10");
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
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    (() async {
      if (await Helper().check()) {
        await searchOrder(
            listSearchOrderBloc,
            loadingBloc,
            apiBloc.currentState.mainUser.id,
            BlocProvider.of<SearchInputBloc>(context).currentState.searchInput,
            widget.isSellOrder ? "2" : "1",
            widget.index == 0 ? "2" : widget.index == 1 ? "1" : "0",
            "1",
            "10");
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
    listSearchOrderBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<ListSearchOrderBloc>(
          bloc: listSearchOrderBloc,
        )
      ],
      child: BlocBuilder(
        bloc: listSearchOrderBloc,
        builder: (context, ListSearchOrderState state) {
          return BlocBuilder(
            bloc: loadingBloc,
            builder: (context, LoadingState loadingState) {
              return isLoading
                  ? ShimmerOrder()
                  : EasyRefresh(
                      key: _easyRefreshKey,
                      refreshHeader: ConnectorHeader(
                          key: _connectorHeaderKey,
                          header: DeliveryHeader(key: _headerKey)),
                      refreshFooter: ConnectorFooter(
                          key: _connectorFooterKeyGrid,
                          footer: ClassicsFooter(
                            key: _footerKeyGrid,
                          )),
                      outerController: widget.scrollController,
                      child: CustomScrollView(
                        controller: widget.scrollController,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate(
                                <Widget>[DeliveryHeader(key: _headerKey)]),
                          ),
                          SliverList(
                              delegate: SliverChildListDelegate(<Widget>[
                            state.listOrder.isEmpty
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        2 /
                                        3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          const IconData(0xe900,
                                              fontFamily: 'box'),
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
                                    ))
                                : Container(
                                    color: colorBackground,
                                    child: StaggeredGridView.countBuilder(
                                        padding: EdgeInsets.only(top: 5),
                                        crossAxisCount: 2,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: state.listOrder.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                SearchOrderItem(
                                                    index,
                                                    widget.index,
                                                    widget.isSellOrder),
                                        staggeredTileBuilder: (int index) =>
                                            new StaggeredTile.fit(2)),
                                  )
                          ])),
                          state.listOrder.isEmpty
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
                        await new Future.delayed(const Duration(seconds: 1),
                            () async {
                          if (await Helper().check()) {
                            setState(() {
                              isLoading = true;
                              begin = 1;
                              end = 10;
                            });
                            listSearchOrderBloc.changeListSearchOrder(
                                listSearchOrderBloc.initialState.listOrder);
                            await searchOrder(
                                listSearchOrderBloc,
                                loadingBloc,
                                apiBloc.currentState.mainUser.id,
                                BlocProvider.of<SearchInputBloc>(context)
                                    .currentState
                                    .searchInput,
                                widget.isSellOrder ? "2" : "1",
                                widget.index == 0
                                    ? "2"
                                    : widget.index == 1 ? "1" : "0",
                                "1",
                                "10");
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            new Future.delayed(const Duration(seconds: 1), () {
                              Toast.show("Vui lòng kiểm tra mạng!", context,
                                  gravity: Toast.CENTER,
                                  backgroundColor: Colors.black87);
                            });
                          }
                        });
                      },
                      loadMore: state.listOrder.isEmpty
                          ? null
                          : () async {
                              if (await Helper().check()) {
                                if (state.listOrder.length == end) {
                                  setState(() {
                                    begin += 10;
                                    end += 10;
                                  });
                                  await searchOrder(
                                      listSearchOrderBloc,
                                      loadingBloc,
                                      apiBloc.currentState.mainUser.id,
                                      BlocProvider.of<SearchInputBloc>(context)
                                          .currentState
                                          .searchInput,
                                      widget.isSellOrder ? "2" : "1",
                                      widget.index == 0
                                          ? "2"
                                          : widget.index == 1 ? "1" : "0",
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
                                new Future.delayed(const Duration(seconds: 1),
                                    () {
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
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
