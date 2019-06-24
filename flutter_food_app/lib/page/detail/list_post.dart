import "package:flutter/material.dart";
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_product_bloc.dart';
import 'package:flutter_food_app/common/state/list_product_state.dart';
import 'package:flutter_food_app/const/color_const.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:toast/toast.dart';

class ListPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost>
    with AutomaticKeepAliveClientMixin {
  FunctionBloc functionBloc;
  ListProductBloc listProductBloc;

  @override
  void initState() {
    super.initState();
    listProductBloc = BlocProvider.of<ListProductBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        BlocBuilder(
          bloc: listProductBloc,
          builder: (context, ListProductState state) {
            return StaggeredGridView.countBuilder(
                padding: EdgeInsets.only(top: 0),
                crossAxisCount: 2,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.listProduct.length,
                itemBuilder: (BuildContext context, int index) => new Card(
                    child: GestureDetector(
                        onTap: () async {
                          if (await checkStatusProduct(
                                  state.listProduct[index].id) ==
                              1) {
                            functionBloc.currentState
                                .navigateToPost(state.listProduct[index].id);
                          } else if (await checkStatusProduct(
                                  state.listProduct[index].id) ==
                              0) {
                            Toast.show("Không thể truy cập!!", context,
                                gravity: Toast.CENTER, duration: 2);
                          } else {
                            Toast.show("Lỗi hệ thống!", context,
                                gravity: Toast.CENTER);
                          }
                        },
                        child: new Container(
                          height: 267,
                          child: Stack(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                    height: 170,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(state
                                              .listProduct[index].images[0]),
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5.0),
                                            topLeft: Radius.circular(5.0))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.0, top: 10.0, left: 10.0),
                                    child: Text(
                                      state.listProduct[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.0,
                                        bottom: 6.0,
                                        left: 10.0,
                                        top: 5.0),
                                    child: Text(
                                      state.listProduct[index].description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: colorText, fontSize: 12),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.0, left: 10.0, bottom: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              Helper().onFormatPrice(state
                                                  .listProduct[index]
                                                  .currentPrice),
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: colorActive,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.favorite,
                                                  color: colorInactive,
                                                  size: 15,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 2.0),
                                                  child: Text(
                                                    state.listProduct[index]
                                                        .amountFav
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: colorInactive,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Helper().onCalculatePercentDiscount(
                                                    state.listProduct[index]
                                                        .initPrice,
                                                    state.listProduct[index]
                                                        .currentPrice) ==
                                                "0%"
                                            ? Container()
                                            : Container(
                                                margin:
                                                    EdgeInsets.only(top: 2.0),
                                                child: Text(
                                                  Helper().onFormatPrice(state
                                                      .listProduct[index]
                                                      .initPrice),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: colorInactive,
                                                    fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Helper().onCalculatePercentDiscount(
                                          state.listProduct[index].initPrice,
                                          state.listProduct[index]
                                              .currentPrice) ==
                                      "0%"
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: 0,
                                          width: 0,
                                        ),
                                        Stack(
                                          children: <Widget>[
                                            Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.red
                                                        .withOpacity(0.9),
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5.0))),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        'GIẢM',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        Helper().onCalculatePercentDiscount(
                                                            state
                                                                .listProduct[
                                                                    index]
                                                                .initPrice,
                                                            state
                                                                .listProduct[
                                                                    index]
                                                                .currentPrice),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.yellow,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14.0),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                            ],
                          ),
                        ))),
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(1));
          },
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
