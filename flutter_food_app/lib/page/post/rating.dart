import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/product_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/product_state.dart';
import 'package:flutter_food_app/common/state/user_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:flutter_food_app/page/authentication/authentication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'list_rating.dart';
import 'package:toast/toast.dart';

class CommentPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommentPostState();
}

class CommentPostState extends State<CommentPost> {
  int itemCount = 3;
  double ratingValue = 5.0;
  final myController = new TextEditingController();
  ProductBloc productBloc;
  final fDay = new DateFormat('h:mm a dd-MM-yyyy');
  UserBloc userBloc;
  ApiBloc apiBloc;
  FunctionBloc functionBloc;

  void _showRatingList(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ListRating(productBloc.currentState.product.id, removeRatingAt, popupRating);
        });
  }

  @override
  void initState() {
    super.initState();
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    super.dispose();
  }

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

  Future removeRatingAt(int index) async {
    await fetchProductById(productBloc,
        productBloc.currentState.product.id);
  }

  void popupRating() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  width: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Đánh giá",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: SmoothStarRating(
                            allowHalfRating: false,
                            rating: ratingValue,
                            starCount: 5,
                            size: 30,
                            color: Colors.yellow,
                            borderColor: Colors.yellow,
                            onRatingChanged: (v) {
                              setState(() {
                                ratingValue = v;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextField(
                          autofocus: true,
                          controller: myController,
                          maxLengthEnforced: true,
                          maxLength: 100,
                          decoration: InputDecoration(
                            hintText: "Nhập bình luận",
                            border: InputBorder.none,
                          ),
                          cursorColor: colorActive,
                          maxLines: 4,
                        ),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: colorActive,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32.0),
                                bottomRight: Radius.circular(32.0)),
                          ),
                          child: Text(
                            "ĐỒNG Ý",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () async {
                          if (myController.text.isEmpty) {
                            Toast.show('Vui lòng nhập nội dung!', context,
                                duration: 2);
                          } else {
                            _showLoading();
                            int check = await addRatingProduct(
                                apiBloc.currentState.mainUser.id,
                                productBloc.currentState.product.id,
                                ratingValue.toInt().toString(),
                                myController.text);
                            if (check == 0) {
                              Toast.show("Lỗi hệ thống!", context);
                              Navigator.pop(context);
                            } else if (check == 2) {
                              Toast.show(
                                  "Bạn đã đánh giá sản phẩm này!", context);
                              Navigator.pop(context);
                            } else {
                              await fetchProductById(productBloc,
                                  productBloc.currentState.product.id);
                              Toast.show('Cảm ơn bạn đã đánh giá!', context,
                                  duration: 2);
                              myController.clear();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  void navigateToUserPage(ProductState state) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InfoAnotherPage(state.product.idUser)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthRating = size.width - 90;
    final widthComment = size.width - 100;
    // TODO: implement build
    return BlocBuilder(
      bloc: productBloc,
      builder: (context, ProductState state) {
        return BlocBuilder(
            bloc: userBloc,
            builder: (context, UserState userState) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 16.0),
                margin: EdgeInsets.only(bottom: 5.0),
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
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'ĐÁNH GIÁ',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    state.product.listRating == null
                        ? Container(
                            width: double.infinity,
                            height: 200,
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
                                    "Không có đánh giá nào nào",
                                    style: TextStyle(
                                      color: colorInactive,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : state.product.listRating.isEmpty
                            ? Container(
                                width: double.infinity,
                                height: 200,
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
                                        "Không có đánh giá nào nào",
                                        style: TextStyle(
                                          color: colorInactive,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: state.product.listRating.length > 3
                                    ? 3
                                    : state.product.listRating.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    Container(
                                        margin: EdgeInsets.only(bottom: 16.0),
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
                                                      state
                                                          .product
                                                          .listRating[index]
                                                          .user
                                                          .avatar,
                                                      fit: BoxFit.cover,
                                                      width: 40.0,
                                                      height: 40.0,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    navigateToUserPage(state);
                                                  },
                                                ),
                                                Container(
                                                  width: widthRating,
                                                  margin: EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            child: Text(
                                                              state
                                                                  .product
                                                                  .listRating[
                                                              index]
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
                                                              navigateToUserPage(
                                                                  state);
                                                            },
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                top: 4.0),
                                                            child: SmoothStarRating(
                                                              starCount: 5,
                                                              size: 16.0,
                                                              rating: state
                                                                  .product
                                                                  .listRating[index]
                                                                  .rating,
                                                              color: Colors.yellow,
                                                              borderColor:
                                                              Colors.yellow,
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                vertical: 8.0),
                                                            child: Text(
                                                              state
                                                                  .product
                                                                  .listRating[index]
                                                                  .comment,
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.black,
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                          Text(
                                                            Helper().formatDay(state
                                                                .product
                                                                .listRating[index]
                                                                .day),
                                                            style: TextStyle(
                                                                color:
                                                                colorInactive,
                                                                fontStyle: FontStyle
                                                                    .italic,
                                                                fontSize: 10),
                                                            textAlign:
                                                            TextAlign.center,
                                                          ),
                                                        ],
                                                      ),
                                                      Positioned(
                                                        right: 0,
                                                        top: -14,
                                                        child: userState.isAdmin ||
                                                            !userState
                                                                .isLogin
                                                            ? Container()
                                                            : (state
                                                            .product
                                                            .listRating[
                                                        index]
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
                                                              popupRating();
                                                            } else {
                                                              _showLoading();
                                                              int check = await removeRatingProduct(state.product.id);
                                                              if(check == 1){
                                                                await fetchProductById(productBloc,
                                                                    productBloc.currentState.product.id);
                                                                Navigator.pop(context);
                                                                Toast.show("Xóa bình luận thành công!", context);
                                                              }
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
                                                      ),
                                                    ],
                                                  )
                                                ),
                                              ],
                                            ),
                                            index != itemCount - 1
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
                    state.product.listRating == null
                        ? Container()
                        : state.product.listRating.length > 3
                            ? GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 50, bottom: 10.0, top: 5.0),
                                  child: Text(
                                    'Xem tất cả',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                onTap: () {
                                  _showRatingList(context);
                                },
                              )
                            : Container(),
                    userBloc.currentState.isAdmin
                        ? Container(
                            height: 20,
                          )
                        : GestureDetector(
                            child: Center(
                              child: Container(
                                margin:
                                    EdgeInsets.only(top: 10.0, bottom: 16.0),
                                width: widthComment,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: colorActive,
                                    border: Border.all(color: colorComment),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Center(
                                  child: Text(
                                    'Đánh giá',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (userState.isLogin) {
                                if (state.product.idUser ==
                                    apiBloc.currentState.mainUser.id) {
                                  Toast.show(
                                      "Không thể đánh giá bài viết của mình!",
                                      context);
                                } else {
                                  popupRating();
                                }
                              } else {
                                functionBloc.onBeforeLogin(() {
                                  if (state.product.idUser ==
                                      apiBloc.currentState.mainUser.id) {
                                    Toast.show(
                                        "Không thể đánh giá bài viết của mình!",
                                        context);
                                  } else {
                                    popupRating();
                                  }
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AuthenticationPage()));
                              }
                            },
                          ),
                  ],
                ),
              );
            });
      },
    );
  }
}
