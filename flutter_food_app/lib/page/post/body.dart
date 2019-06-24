import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/product_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/product_state.dart';
import 'package:flutter_food_app/common/state/user_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:flutter_food_app/page/authentication/authentication.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
import 'package:share/share.dart';

class PostBody extends StatefulWidget {
  final String idProduct;

  PostBody(this.idProduct);

  @override
  State<StatefulWidget> createState() => PostBodyState();
}

class PostBodyState extends State<PostBody> {
  ApiBloc apiBloc;
  ProductBloc productBloc;
  UserBloc userBloc;
  bool onTapFav = false;
  bool isFavorite = false;
  int amountFav = 0;
  bool isHide = true;
  FunctionBloc functionBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    userBloc = BlocProvider.of<UserBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    (() async {
      if (apiBloc.currentState.mainUser != null) {
        if (await checkIsFavorite(
                apiBloc.currentState.mainUser.id, widget.idProduct) ==
            1) {
          setState(() {
            isFavorite = true;
          });
        }
      }
    })();
    setState(() {
      amountFav = productBloc.currentState.product.amountFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: userBloc,
      builder: (context, UserState userState) {
        return BlocBuilder(
          bloc: apiBloc,
          builder: (context, ApiState state) {
            return BlocBuilder(
              bloc: productBloc,
              builder: (context, ProductState productState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            bottom: 12.0, left: 15.0, right: 15.0, top: 15.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              productState.product.name,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontFamily: "Ralway",
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                            right: 2.0,
                                          ),
                                          child: Text(
                                            Helper().onFormatPrice(productState
                                                .product.currentPrice),
                                            style: TextStyle(
                                              color: colorActive,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 4.0, left: 2.0),
                                          child: Text(
                                            '/',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            right: 10.0,
                                          ),
                                          child: Text(
                                            productState.product.unit,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () async {
                                            if (await checkStatusProduct(
                                                    widget.idProduct) ==
                                                1) {
                                              Share.share(
                                                  'https://datnk15.herokuapp.com/product-detail/' +
                                                      productState.product.id);
                                            } else if (await checkStatusProduct(
                                                    widget.idProduct) ==
                                                0) {
                                              Toast.show(
                                                  "Không thể chia sẽ sản phẩm bị xóa!",
                                                  context,
                                                  gravity: Toast.CENTER,
                                                  duration: 2);
                                            } else {
                                              Toast.show(
                                                  "Lỗi hệ thống!", context,
                                                  gravity: Toast.CENTER);
                                            }
                                          },
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(right: 15.0),
                                            child: Icon(
                                              Icons.share,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () async {
                                              if (!userState.isAdmin) {
                                                if (userState.isLogin) {
                                                  if (!onTapFav) {
                                                    if (await checkIsFavorite(
                                                            apiBloc.currentState
                                                                .mainUser.id,
                                                            widget.idProduct) ==
                                                        1) {
                                                      setState(() {
                                                        onTapFav = true;
                                                      });
                                                      await isAddToFav(
                                                          apiBloc,
                                                          state.mainUser.id,
                                                          widget.idProduct,
                                                          false);
                                                      setState(() {
                                                        isFavorite = false;
                                                        onTapFav = false;
                                                        setState(() {
                                                          amountFav--;
                                                        });
                                                      });
                                                      Toast.show(
                                                          "Đã xóa khỏi danh sách yêu thích!",
                                                          context,
                                                          gravity:
                                                              Toast.CENTER);
                                                    } else {
                                                      setState(() {
                                                        onTapFav = true;
                                                      });
                                                      if (await checkStatusProduct(
                                                              widget
                                                                  .idProduct) ==
                                                          1) {
                                                        await isAddToFav(
                                                            apiBloc,
                                                            state.mainUser.id,
                                                            widget.idProduct,
                                                            true);
                                                      } else if (await checkStatusProduct(
                                                              widget
                                                                  .idProduct) ==
                                                          0) {
                                                        Toast.show(
                                                            "Không thể thêm yêu thích sản phẩm bị xóa!",
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
                                                      setState(() {
                                                        isFavorite = true;
                                                        onTapFav = false;
                                                        setState(() {
                                                          amountFav++;
                                                        });
                                                      });
                                                      Toast.show(
                                                          "Đã thêm vào danh sách yêu thích!",
                                                          context,
                                                          gravity:
                                                              Toast.CENTER);
                                                    }
                                                  }
                                                } else {
                                                  functionBloc
                                                      .onBeforeLogin(() async {
                                                    if (apiBloc.currentState
                                                            .mainUser !=
                                                        null) {
                                                      if (await checkIsFavorite(
                                                              apiBloc
                                                                  .currentState
                                                                  .mainUser
                                                                  .id,
                                                              widget
                                                                  .idProduct) ==
                                                          1) {
                                                        setState(() {
                                                          isFavorite = true;
                                                        });
                                                      }
                                                    }
                                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AuthenticationPage()));
                                                }
                                              }
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.favorite,
                                                  color: userState.isLogin
                                                      ? isFavorite
                                                          ? Colors.red
                                                          : colorInactive
                                                      : colorInactive,
                                                  size: 20,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 2.0, bottom: 1.0),
                                                  child: Text(
                                                    amountFav.toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Ralway"),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        )),
                    Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Overall Rating',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: colorInactive),
                                        ),
                                        Text(
                                          productState.product.rate
                                              .toStringAsFixed(1),
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: colorActive),
                                        ),
                                        SmoothStarRating(
                                          starCount: 5,
                                          size: 22.0,
                                          rating: productState.product != null
                                              ? productState.product.rate
                                              : 0,
                                          color: Colors.yellow,
                                          allowHalfRating: false,
                                          borderColor: Colors.yellow,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'GIỚI THIỆU',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          margin: EdgeInsets.only(left: 8.0),
                                          decoration: BoxDecoration(
                                              color: colorComment,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              border: Border.all(
                                                  color: colorComment)),
                                          child: Center(
                                            child: Text(
                                              Helper().timeAgo(
                                                  productState.product.date),
                                              style: TextStyle(
                                                color: colorInactive,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      productState.product.description,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(bottom: 5.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  'THÔNG TIN NGƯỜI ĐĂNG',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5.0),
                                    child: GestureDetector(
                                      child: Text(
                                        productState.product == null
                                            ? ""
                                            : productState
                                                .product.user.username,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: colorActive),
                                      ),
                                      onTap: () {
                                        if (state.mainUser == null ||
                                            (state.mainUser != null &&
                                                productState.product.idUser !=
                                                    state.mainUser.id)) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InfoAnotherPage(
                                                          productState.product
                                                              .idUser)));
                                        } else {}
                                      },
                                    ),
                                  ),
                                  SmoothStarRating(
                                    starCount: 5,
                                    size: 18.0,
                                    rating: productState.product == null
                                        ? 0
                                        : productState.product.user.rate,
                                    color: Colors.yellow,
                                    borderColor: Colors.yellow,
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.home,
                                        size: 20,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        productState.product == null
                                            ? ""
                                            : productState.product.user.address,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.phone,
                                        size: 20,
                                      ),
                                    ),
                                    isHide
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isHide = false;
                                              });
                                            },
                                            child: Text(
                                              "Nhấn để hiện số điện thoại",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            productState.product == null
                                                ? ""
                                                : productState
                                                    .product.user.phone,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
