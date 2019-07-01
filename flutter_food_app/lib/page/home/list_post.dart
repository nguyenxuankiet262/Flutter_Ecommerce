import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';

class ListPost extends StatefulWidget {
  final int index;

  ListPost(this.index);

  @override
  State<StatefulWidget> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  ApiBloc apiBloc;
  FunctionBloc functionBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return (widget.index == 0 && state.tenNewest.isEmpty ||
                widget.index == 1 && state.tenMostFav.isEmpty)
            ? Container(
                height: 283,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      const IconData(0xe900, fontFamily: 'box'),
                      size: 100,
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
                height: 283,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.index == 0
                      ? state.tenNewest.length
                      : state.tenMostFav.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => new Card(
                      margin: EdgeInsets.only(
                          left: 8.0,
                          top: 8.0,
                          bottom: 8.0,
                          right: widget.index == 0
                              ? index == state.tenNewest.length - 1 ? 8 : 0
                              : index == state.tenMostFav.length - 1 ? 8 : 0),
                      child: GestureDetector(
                        onTap: () async {
                          widget.index == 0
                              ? functionBloc.currentState
                              .navigateToPost(state.tenNewest[index].id)
                              : functionBloc.currentState
                              .navigateToPost(state.tenMostFav[index].id);
                        },
                        child: new Container(
                          width: 200,
                          child: Stack(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                    height: 170,
                                    decoration: widget.index == 0
                                        ? BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(state
                                                  .tenNewest[index].images[0]),
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5.0),
                                                topLeft: Radius.circular(5.0)))
                                        : BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(state
                                                  .tenMostFav[index].images[0]),
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5.0),
                                                topLeft: Radius.circular(5.0))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.0, top: 10.0, left: 10.0),
                                    child: Text(
                                      widget.index == 0
                                          ? state.tenNewest[index].name
                                          : state.tenMostFav[index].name,
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
                                      widget.index == 0
                                          ? state.tenNewest[index].description
                                          : state.tenMostFav[index].description,
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
                                              widget.index == 0
                                                  ? Helper().onFormatPrice(state
                                                      .tenNewest[index]
                                                      .currentPrice)
                                                  : Helper().onFormatPrice(state
                                                      .tenMostFav[index]
                                                      .currentPrice),
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: colorActive,
                                                  fontWeight: FontWeight.w600),
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
                                                    widget.index == 0
                                                        ? state.tenNewest[index]
                                                            .amountFav
                                                            .toString()
                                                        : state
                                                            .tenMostFav[index]
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
                                        widget.index == 0
                                            ? (Helper().onCalculatePercentDiscount(
                                                        state.tenNewest[index]
                                                            .initPrice,
                                                        state.tenNewest[index]
                                                            .currentPrice) ==
                                                    "0%")
                                                ? Container()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        top: 2.0),
                                                    child: Text(
                                                      Helper().onFormatPrice(
                                                          state.tenNewest[index]
                                                              .initPrice),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: colorInactive,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  )
                                            : (Helper().onCalculatePercentDiscount(
                                                        state.tenMostFav[index]
                                                            .initPrice,
                                                        state.tenMostFav[index]
                                                            .currentPrice) ==
                                                    "0%")
                                                ? Container()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        top: 2.0),
                                                    child: Text(
                                                      Helper().onFormatPrice(
                                                          state
                                                              .tenMostFav[index]
                                                              .initPrice),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: colorInactive,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              widget.index == 0
                                  ? (Helper().onCalculatePercentDiscount(
                                              state.tenNewest[index].initPrice,
                                              state.tenNewest[index]
                                                  .currentPrice) ==
                                          "0%")
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
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        5.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5.0))),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            'GIẢM',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            Helper().onCalculatePercentDiscount(
                                                                state
                                                                    .tenNewest[
                                                                        index]
                                                                    .initPrice,
                                                                state
                                                                    .tenNewest[
                                                                        index]
                                                                    .currentPrice),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .yellow,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14.0),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            )
                                          ],
                                        )
                                  : (Helper().onCalculatePercentDiscount(
                                              state.tenMostFav[index].initPrice,
                                              state.tenMostFav[index]
                                                  .currentPrice) ==
                                          "0%")
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
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        5.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5.0))),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            'GIẢM',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            Helper().onCalculatePercentDiscount(
                                                                state
                                                                    .tenMostFav[
                                                                        index]
                                                                    .initPrice,
                                                                state
                                                                    .tenMostFav[
                                                                        index]
                                                                    .currentPrice),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .yellow,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14.0),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            )
                                          ],
                                        )
                            ],
                          ),
                        ),
                      )),
                ),
              );
      },
    );
  }
}
