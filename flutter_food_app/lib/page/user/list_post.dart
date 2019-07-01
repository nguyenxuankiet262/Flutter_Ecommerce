import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class ListPost extends StatefulWidget {
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

  Widget build(BuildContext context) {
    // TODO: implement build
    return new BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState apiState) {
        return apiState.mainUser == null
            ? Shimmer.fromColors(
                child: Container(
                  height: 400,
                  color: Colors.white,
                ),
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
              )
            : apiState.mainUser.listProductShow == null
                ? Shimmer.fromColors(
                    child: Container(
                      height: 400,
                      color: Colors.white,
                    ),
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                  )
                : apiState.mainUser.listProductShow.isEmpty
                    ? Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height -
                            19,
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
                        child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          StaggeredGridView.countBuilder(
                            padding: EdgeInsets.only(top: 0),
                            crossAxisCount: 2,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: apiState.mainUser.listProductShow.length,
                            itemBuilder: (BuildContext context, int index) =>
                                GestureDetector(
                                  onTap: () async {
                                    functionBloc.currentState.navigateToPost(
                                        apiState.mainUser
                                            .listProductShow[index].id);
                                  },
                                  child: new Card(
                                    child: Stack(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Container(
                                              height: 170,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(apiState
                                                        .mainUser
                                                        .listProductShow[index]
                                                        .images[0]),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  5.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0))),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10.0,
                                                  top: 10.0,
                                                  left: 10.0),
                                              child: Text(
                                                apiState
                                                    .mainUser
                                                    .listProductShow[index]
                                                    .name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10.0,
                                                  bottom: 6.0,
                                                  left: 10.0,
                                                  top: 5.0),
                                              child: Text(
                                                apiState
                                                    .mainUser
                                                    .listProductShow[index]
                                                    .description,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: colorText,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10.0,
                                                  left: 10.0,
                                                  bottom: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        Helper().onFormatPrice(
                                                            apiState
                                                                .mainUser
                                                                .listProductShow[
                                                                    index]
                                                                .currentPrice),
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: colorActive,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.favorite,
                                                            color:
                                                                colorInactive,
                                                            size: 15,
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 2.0),
                                                            child: Text(
                                                              apiState
                                                                  .mainUser
                                                                  .listProductShow[
                                                                      index]
                                                                  .amountFav
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color:
                                                                      colorInactive,
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  (Helper().onCalculatePercentDiscount(
                                                              apiState
                                                                  .mainUser
                                                                  .listProductShow[
                                                                      index]
                                                                  .initPrice,
                                                              apiState
                                                                  .mainUser
                                                                  .listProductShow[
                                                                      index]
                                                                  .currentPrice) ==
                                                          "0%")
                                                      ? Container(
                                                          height: 17.3,
                                                        )
                                                      : Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 2.0),
                                                          child: Text(
                                                            Helper().onFormatPrice(
                                                                apiState
                                                                    .mainUser
                                                                    .listProductShow[
                                                                        index]
                                                                    .initPrice),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  colorInactive,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        (Helper().onCalculatePercentDiscount(
                                                    apiState
                                                        .mainUser
                                                        .listProductShow[index]
                                                        .initPrice,
                                                    apiState
                                                        .mainUser
                                                        .listProductShow[index]
                                                        .currentPrice) ==
                                                "0%")
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                                  .withOpacity(
                                                                      0.9),
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5.0))),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'GIẢM',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Text(
                                                                  Helper().onCalculatePercentDiscount(
                                                                      apiState
                                                                          .mainUser
                                                                          .listProductShow[
                                                                              index]
                                                                          .initPrice,
                                                                      apiState
                                                                          .mainUser
                                                                          .listProductShow[
                                                                              index]
                                                                          .currentPrice),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .yellow,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14.0),
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
                                  ),
                                ),
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.fit(1),
                          ),
                          apiState.mainUser.listProductShow.length > 5
                              ? Container()
                              : Container(
                                  height: 200,
                                  color: colorBackground,
                                )
                        ],
                      ));
      },
    );
  }
}
