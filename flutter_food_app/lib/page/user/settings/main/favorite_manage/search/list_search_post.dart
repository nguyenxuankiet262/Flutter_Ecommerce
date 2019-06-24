import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/favorite_manage_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/load_more_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/list_search_product_state.dart';
import 'package:flutter_food_app/common/state/load_more_state.dart';
import 'package:flutter_food_app/common/state/loading_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';

class ListSearchPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListSearchPostState();
}

class _ListSearchPostState extends State<ListSearchPost>
    with AutomaticKeepAliveClientMixin {
  LoadingBloc loadingBloc;
  ListSearchProductBloc listSearchProductBloc;
  FunctionBloc functionBloc;
  FavoriteManageBloc favoriteManageBloc;
  SearchInputBloc searchInputBloc;
  ApiBloc apiBloc;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKeyGrid =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshFooterState> _connectorFooterKeyGrid =
      new GlobalKey<RefreshFooterState>();
  final loadMoreBloc = LoadMoreBloc();

  @override
  void initState() {
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    favoriteManageBloc = BlocProvider.of<FavoriteManageBloc>(context);
    searchInputBloc = BlocProvider.of<SearchInputBloc>(context);
    listSearchProductBloc = BlocProvider.of<ListSearchProductBloc>(context);
    functionBloc.onRefreshLoadMore(_onRefreshLoadMore);
  }

  void _onRefreshLoadMore() {
    listSearchProductBloc.changeListSearchProduct(
        listSearchProductBloc.initialState.listProduct);
    loadMoreBloc.changeLoadMore(1, 10);
  }

  @override
  void dispose() {
    super.dispose();
    loadMoreBloc.dispose();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProviderTree(
        blocProviders: [BlocProvider<LoadMoreBloc>(bloc: loadMoreBloc)],
        child: BlocBuilder(
          bloc: loadingBloc,
          builder: (context, LoadingState state) {
            return BlocBuilder(
              bloc: listSearchProductBloc,
              builder: (context, ListSearchProductState searchState) {
                return BlocBuilder(
                  bloc: loadMoreBloc,
                  builder: (context, LoadMoreState loadmoreState) {
                    return state.loadingSearch
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            color: Colors.transparent,
                            child: ListView(
                              children: <Widget>[
                                Container(
                                    height: MediaQuery.of(context).size.height -
                                        200,
                                    child: Center(
                                        child: SpinKitFadingCircle(
                                      color: Colors.white,
                                      size: 50.0,
                                    )))
                              ],
                            ))
                        : searchState.listProduct.isEmpty
                            ? Container(
                                width: double.infinity,
                                color: Colors.white,
                                height: MediaQuery.of(context).size.height,
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
                                height: MediaQuery.of(context).size.height,
                                child: new EasyRefresh(
                                  key: _easyRefreshKey,
                                  refreshFooter: ConnectorFooter(
                                      key: _connectorFooterKeyGrid,
                                      footer: ClassicsFooter(
                                        key: _footerKeyGrid,
                                      )),
                                  child: CustomScrollView(
                                    slivers: <Widget>[
                                      SliverList(
                                        delegate:
                                            SliverChildListDelegate(<Widget>[
                                          ListView.builder(
                                              itemCount: searchState
                                                  .listProduct.length,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (BuildContext
                                                          context,
                                                      int index) =>
                                                  GestureDetector(
                                                      onTap: () async {
                                                        if (await checkStatusProduct(
                                                                searchState
                                                                    .listProduct[
                                                                        index]
                                                                    .id) ==
                                                            1) {
                                                          functionBloc
                                                              .currentState
                                                              .navigateToPost(
                                                                  searchState
                                                                      .listProduct[
                                                                          index]
                                                                      .id);
                                                        } else if (await checkStatusProduct(
                                                                searchState
                                                                    .listProduct[
                                                                        index]
                                                                    .id) ==
                                                            0) {
                                                          Toast.show(
                                                              "Không thể truy cập!",
                                                              context,
                                                              gravity:
                                                                  Toast.CENTER,
                                                              duration: 2);
                                                        } else {
                                                          Toast.show(
                                                              "Lỗi hệ thống!",
                                                              context,
                                                              gravity:
                                                                  Toast.CENTER);
                                                        }
                                                      },
                                                      child: Card(
                                                          color: Colors.white,
                                                          margin: EdgeInsets.only(
                                                              right: 8.0,
                                                              left: 8.0,
                                                              top: 8,
                                                              bottom: index ==
                                                                      searchState
                                                                              .listProduct
                                                                              .length -
                                                                          1
                                                                  ? 8.0
                                                                  : 0.0),
                                                          child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              16.0,
                                                                          right:
                                                                              16.0,
                                                                          left:
                                                                              16.0,
                                                                          bottom:
                                                                              16),
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                          64,
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                                Container(
                                                                              child: ClipRRect(
                                                                                child: Image.network(
                                                                                  searchState.listProduct[index].images[0],
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                                borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                                                                              ),
                                                                              width: 105,
                                                                              height: 90,
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  height: 65,
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: <Widget>[
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(right: 10.0, left: 15.0),
                                                                                        child: Text(
                                                                                          searchState.listProduct[index].name,
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(right: 10.0, bottom: 5.0, left: 15.0, top: 5.0),
                                                                                        child: Text(
                                                                                          searchState.listProduct[index].description,
                                                                                          maxLines: 2,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: TextStyle(color: colorText, fontSize: 14),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(
                                                                                    top: 4.0,
                                                                                    right: 10.0,
                                                                                    left: 15.0,
                                                                                  ),
                                                                                  child: Text(
                                                                                    Helper().onFormatPrice(searchState.listProduct[index].currentPrice),
                                                                                    style: TextStyle(color: colorActive, fontWeight: FontWeight.bold, fontSize: 17.0),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ]))))
                                        ]),
                                      ),
                                      searchState.listProduct.isEmpty
                                          ? SliverList(
                                              delegate: SliverChildListDelegate(
                                                  <Widget>[]),
                                            )
                                          : SliverList(
                                              delegate:
                                                  SliverChildListDelegate(<
                                                      Widget>[
                                                ClassicsFooter(
                                                  key: _footerKeyGrid,
                                                  loadHeight: 50.0,
                                                  bgColor: colorBackground,
                                                )
                                              ]),
                                            )
                                    ],
                                  ),
                                  loadMore: searchState.listProduct.isEmpty
                                      ? null
                                      : () async {
                                          if (await Helper().check()) {
                                            if (searchState
                                                    .listProduct.length ==
                                                loadmoreState.end) {
                                              loadMoreBloc.changeLoadMore(
                                                  loadmoreState.begin + 10,
                                                  loadmoreState.end + 10);
                                              if (favoriteManageBloc
                                                      .currentState
                                                      .indexCategory ==
                                                  0) {
                                                print(loadmoreState.begin + 10);
                                                print(loadmoreState.end + 10);
                                                await searchFavAllOfUser(
                                                  listSearchProductBloc,
                                                  loadingBloc,
                                                  apiBloc
                                                      .currentState.mainUser.id,
                                                  searchInputBloc
                                                      .currentState.searchInput,
                                                  favoriteManageBloc
                                                      .currentState.code
                                                      .toString(),
                                                  favoriteManageBloc
                                                      .currentState.min
                                                      .toString(),
                                                  favoriteManageBloc
                                                      .currentState.max
                                                      .toString(),
                                                  (loadmoreState.begin + 10)
                                                      .toString(),
                                                  (loadmoreState.end + 10)
                                                      .toString(),
                                                );
                                              } else {
                                                if (favoriteManageBloc
                                                        .currentState
                                                        .indexChildCategory ==
                                                    0) {
                                                  await searchFavOfMenuOfUser(
                                                      listSearchProductBloc,
                                                      loadingBloc,
                                                      apiBloc
                                                          .currentState
                                                          .listMenu[
                                                              favoriteManageBloc
                                                                  .currentState
                                                                  .indexCategory]
                                                          .id,
                                                      apiBloc.currentState
                                                          .mainUser.id,
                                                      searchInputBloc
                                                          .currentState
                                                          .searchInput,
                                                      favoriteManageBloc
                                                          .currentState.code
                                                          .toString(),
                                                      favoriteManageBloc
                                                          .currentState.min
                                                          .toString(),
                                                      favoriteManageBloc
                                                          .currentState.max
                                                          .toString(),
                                                      (loadmoreState.begin + 10)
                                                          .toString(),
                                                      (loadmoreState.end + 10)
                                                          .toString());
                                                } else {
                                                  await searchFavOfChildMenuOfUser(
                                                      listSearchProductBloc,
                                                      loadingBloc,
                                                      apiBloc
                                                          .currentState
                                                          .listMenu[favoriteManageBloc
                                                              .currentState
                                                              .indexCategory]
                                                          .listChildMenu[
                                                              favoriteManageBloc
                                                                  .currentState
                                                                  .indexChildCategory]
                                                          .id,
                                                      apiBloc.currentState
                                                          .mainUser.id,
                                                      searchInputBloc
                                                          .currentState
                                                          .searchInput,
                                                      favoriteManageBloc
                                                          .currentState.code
                                                          .toString(),
                                                      favoriteManageBloc
                                                          .currentState.min
                                                          .toString(),
                                                      favoriteManageBloc
                                                          .currentState.max
                                                          .toString(),
                                                      (loadmoreState.begin + 10)
                                                          .toString(),
                                                      (loadmoreState.end + 10)
                                                          .toString());
                                                }
                                              }
                                              _footerKeyGrid.currentState
                                                  .onLoadEnd();
                                            } else {
                                              await new Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () {});
                                              _footerKeyGrid.currentState
                                                  .onNoMore();
                                              _footerKeyGrid.currentState
                                                  .onLoadClose();
                                            }
                                          } else {
                                            new Future.delayed(
                                                const Duration(seconds: 1), () {
                                              Toast.show(
                                                  "Vui lòng kiểm tra mạng!",
                                                  context,
                                                  gravity: Toast.CENTER,
                                                  backgroundColor:
                                                      Colors.black87);
                                            });
                                          }
                                        },
                                ));
                  },
                );
              },
            );
          },
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
