import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_food_app/page/user/info.dart';

class RelativePost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RelativePostState();
}

class RelativePostState extends State<RelativePost> {
  int itemCount = 10;
  ApiBloc apiBloc;

  void navigateToUserPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InfoPage(true)));
  }

  void navigateToPost() {}

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
      builder: (context, ApiState apiState) {
        return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 7.0, top: 15.0),
                  child: Text(
                    'BÀI VIẾT TƯƠNG TỰ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                apiState.product.relativeProduct == null
                    ? Container(
                        width: double.infinity,
                        height: 400,
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
                        crossAxisCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: apiState.product.relativeProduct.length,
                        itemBuilder: (BuildContext context, int index) =>
                            new Card(
                              child: new Container(
                                height: 230,
                                width: 200,
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                            height: 130,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(apiState
                                                      .product
                                                      .relativeProduct[index]
                                                      .images[0]),
                                                ),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    topLeft:
                                                        Radius.circular(5.0))),
                                          ),
                                          onTap: () {
                                            navigateToPost();
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 10.0,
                                              top: 10.0,
                                              left: 10.0),
                                          child: Text(
                                            apiState.product
                                                .relativeProduct[index].name,
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
                                            apiState
                                                .product
                                                .relativeProduct[index]
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
                                              Text(
                                                Helper().onFormatPrice(apiState
                                                    .product
                                                    .relativeProduct[index]
                                                    .currentPrice),
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: colorActive,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 2.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      Helper().onFormatPrice(
                                                          apiState
                                                              .product
                                                              .relativeProduct[
                                                                  index]
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
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.favorite,
                                                          color: colorInactive,
                                                          size: 15,
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 2.0),
                                                          child: Text(
                                                            '100',
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
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
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
                                                    color: Colors.orangeAccent
                                                        .withOpacity(0.95),
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
                                                            apiState
                                                                .product
                                                                .relativeProduct[
                                                                    index]
                                                                .initPrice,
                                                            apiState
                                                                .product
                                                                .relativeProduct[
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
                              ),
                            ),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(1),
                      ),
              ],
            ));
      },
    );
  }
}
