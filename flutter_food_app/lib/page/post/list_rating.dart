import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/rating_product.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

class ListRating extends StatefulWidget {
  final String idProduct;
  final Function removeRating, editRating;

  ListRating(this.idProduct, this.removeRating, this.editRating);

  @override
  State<StatefulWidget> createState() => ListRatingState();
}

class ListRatingState extends State<ListRating> {
  List<RatingProduct> listRating;
  FunctionBloc functionBloc;
  UserBloc userBloc;
  ApiBloc apiBloc;
  final fDay = new DateFormat('h:mm a dd-MM-yyyy');
  int begin = 0;
  int end = 0;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKeyGrid =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshFooterState> _connectorFooterKeyGrid =
      new GlobalKey<RefreshFooterState>();

  void _showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of(context);
    userBloc = BlocProvider.of(context);
    functionBloc = BlocProvider.of(context);
    listRating = null;
    (() async {
      if (await Helper().check()) {
        List<RatingProduct> listTemp =
            await fetchListRatingOfProduct(widget.idProduct, "1", "10");
        setState(() {
          listRating = listTemp;
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthRating = size.width - 90;
    final height = size.height - 60;
    return Container(
      height: height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Container(
                  width: 50,
                  height: 2,
                  color: colorInactive,
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 16.0, left: 16.0),
            child: Text(
              'ĐÁNH GIÁ',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: height - 60,
            child: listRating == null
                ? Center(
                    child: SpinKitFadingCircle(
                      color: colorActive,
                      size: 50.0,
                    ),
                  )
                : Scrollbar(
                    child: EasyRefresh(
                    key: _easyRefreshKey,
                    refreshFooter: ConnectorFooter(
                        key: _connectorFooterKeyGrid,
                        footer: ClassicsFooter(
                          bgColor: Colors.white,
                          key: _footerKeyGrid,
                        )),
                    child: CustomScrollView(
                      shrinkWrap: true,
                      slivers: <Widget>[
                        SliverList(
                            delegate: SliverChildListDelegate(<Widget>[
                          ListView.builder(
                            itemCount: listRating.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                                    margin: EdgeInsets.only(
                                        bottom: 16.0, left: 16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            GestureDetector(
                                              child: ClipOval(
                                                child: Image.network(
                                                  listRating[index].user.avatar,
                                                  fit: BoxFit.cover,
                                                  width: 40.0,
                                                  height: 40.0,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => InfoAnotherPage(listRating[index].user.id)));
                                              },
                                            ),
                                            Container(
                                              width: widthRating,
                                              margin:
                                                  EdgeInsets.only(left: 16.0),
                                              child: Stack(
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        child: Text(
                                                          listRating[index]
                                                              .user
                                                              .name,
                                                          style: TextStyle(
                                                              color:
                                                              colorActive,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: 12),
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => InfoAnotherPage(listRating[index].user.id)));
                                                        },
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 4.0),
                                                        child: SmoothStarRating(
                                                          starCount: 5,
                                                          size: 16.0,
                                                          rating: listRating[index]
                                                              .rating,
                                                          color: Colors.yellow,
                                                          borderColor:
                                                          Colors.yellow,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8.0),
                                                        child: Text(
                                                          listRating[index].comment,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      Text(
                                                        Helper().formatDay(listRating[index].day),
                                                        style: TextStyle(
                                                            color: colorInactive,
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            fontSize: 10),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                  Positioned(
                                                    top: -14,
                                                    right: 0,
                                                    child: userBloc.currentState.isAdmin ||
                                                        !userBloc.currentState
                                                            .isLogin
                                                        ? Container()
                                                        : (listRating[index]
                                                        .iduserrating ==
                                                        apiBloc
                                                            .currentState
                                                            .mainUser
                                                            .id)
                                                        ? PopupMenuButton<
                                                        int>(
                                                      onSelected:
                                                          (int
                                                      result) async {
                                                        if (result ==
                                                            1) {
                                                          Navigator.of(context).pop();
                                                          widget.editRating();
                                                        } else {
                                                          _showLoading();
                                                          int check = await removeRatingProduct(widget.idProduct);
                                                          if(check == 1){
                                                            setState(() {
                                                              listRating.removeAt(index);
                                                            });
                                                            if(index < 3){
                                                              widget.removeRating(index);
                                                            }
                                                          }
                                                          Navigator.pop(context);
                                                          Toast.show("Xóa bình luận thành công!", context);
                                                        }
                                                      },
                                                      itemBuilder:
                                                          (BuildContext context) =>
                                                      <PopupMenuEntry<int>>[
                                                        const PopupMenuItem<int>(
                                                          value: 1,
                                                          child: Text('Chỉnh sửa đánh giá'),
                                                        ),
                                                        const PopupMenuItem<int>(
                                                          value: 2,
                                                          child: Text('Xóa đánh giá'),
                                                        ),
                                                      ],
                                                      tooltip:
                                                      "Chức năng",
                                                    )
                                                        : Container()
                                                  )
                                                ],
                                              )
                                            ),
                                          ],
                                        ),
                                        index != listRating.length - 1
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    top: 16.0, right: 16.0),
                                                height: 0.5,
                                                width: double.infinity,
                                                color: colorInactive,
                                              )
                                            : Container(),
                                      ],
                                    )),
                          ),
                        ])),
                        listRating == null
                            ? SliverList(
                                delegate: SliverChildListDelegate(<Widget>[]),
                              )
                            : SliverList(
                                delegate: SliverChildListDelegate(<Widget>[
                                  ClassicsFooter(
                                    bgColor: Colors.white,
                                    key: _footerKeyGrid,
                                    loadHeight: 50.0,
                                  )
                                ]),
                              )
                      ],
                    ),
                    loadMore: listRating == null
                        ? null
                        : () async {
                            if (await Helper().check()) {
                              if (listRating.length == end) {
                                setState(() {
                                  begin += 10;
                                  end += 10;
                                });
                                List<RatingProduct> listTemp =
                                await fetchListRatingOfProduct(widget.idProduct, begin.toString(), end.toString());
                                List<RatingProduct> listRatingProducts =
                                List.from(listRating)
                                  ..addAll(listTemp);
                                setState(() {
                                  listRating = listRatingProducts;
                                });
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
                  )),
          ),
        ],
      ),
    );
  }
}
