import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toast/toast.dart';

class ListPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost>
    with AutomaticKeepAliveClientMixin {
  ApiBloc apiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return Container(
            color: colorBackground,
            child: state.mainUser.listFav == null
                ? Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 200,
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
                : StaggeredGridView.countBuilder(
                    padding: EdgeInsets.only(top: 0),
                    crossAxisCount: 2,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.mainUser.listFav.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                          child: new Card(
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
                                            image: NetworkImage(state.mainUser
                                                .listFav[index].images[0]),
                                          ),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5.0),
                                              topLeft: Radius.circular(5.0))),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 10.0, top: 10.0, left: 10.0),
                                      child: Text(
                                        state.mainUser.listFav[index].name,
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
                                        state.mainUser.listFav[index]
                                            .description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: colorText, fontSize: 12),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                Helper().onFormatPrice(state
                                                    .mainUser
                                                    .listFav[index]
                                                    .currentPrice),
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: colorActive,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                      state
                                                          .mainUser
                                                          .listFav[index]
                                                          .amountFav
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: colorInactive,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Helper().onCalculatePercentDiscount(
                                                      state
                                                          .mainUser
                                                          .listFav[index]
                                                          .initPrice,
                                                      state
                                                          .mainUser
                                                          .listFav[index]
                                                          .currentPrice) ==
                                                  "0%"
                                              ? Container()
                                              : Container(
                                                  margin:
                                                      EdgeInsets.only(top: 2.0),
                                                  child: Text(
                                                    Helper().onFormatPrice(state
                                                        .mainUser
                                                        .listFav[index]
                                                        .initPrice),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: colorInactive,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(),
                                    Helper().onCalculatePercentDiscount(
                                                state.mainUser.listFav[index]
                                                    .initPrice,
                                                state.mainUser.listFav[index]
                                                    .currentPrice) ==
                                            "0%"
                                        ? Container()
                                        : Stack(
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
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          Helper().onCalculatePercentDiscount(
                                                              state
                                                                  .mainUser
                                                                  .listFav[
                                                                      index]
                                                                  .initPrice,
                                                              state
                                                                  .mainUser
                                                                  .listFav[
                                                                      index]
                                                                  .currentPrice),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.yellow,
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
                                ),
                                index != 1000
                                    ? Container()
                                    : Container(
                                        height: 170,
                                        color: Colors.white54,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            margin: EdgeInsets.all(8.0),
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100)),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1),
                                                color: colorActive),
                                            child: Center(
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ))
                              ],
                            ),
                          )),
                          onTap: () async {
                            if (await checkStatusProduct(
                                    state.mainUser.listFav[index].id) ==
                                1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Post(
                                          state.mainUser.listFav[index].id)));
                            } else if (await checkStatusProduct(
                                    state.mainUser.listFav[index].id) ==
                                0) {
                              Toast.show("Không thể truy cập!", context,
                                  gravity: Toast.CENTER, duration: 2);
                            } else {
                              Toast.show("Lỗi hệ thống!", context,
                                  gravity: Toast.CENTER);
                            }
                          },
                        ),
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(1)));
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
