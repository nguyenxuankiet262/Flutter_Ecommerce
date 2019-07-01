import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/items.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';
import 'favorite_item.dart';

class CartItem extends StatefulWidget {
  final int _index;

  CartItem(this._index);

  @override
  State<StatefulWidget> createState() => CartItemState();
}

class CartItemState extends State<CartItem> {
  ApiBloc apiBloc;
  FunctionBloc functionBloc;
  GlobalKey<FavoriteItemState> globalKey = GlobalKey();

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
        return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(
                top: 16.0,
                right: 16.0,
                left: 16.0,
                bottom: widget._index == 5 ? 16.0 : 0.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15.0, left: 15.0),
                    width: MediaQuery.of(context).size.width - 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            functionBloc.currentState.navigateToPost(
                                state.cart.products[widget._index].id);
                          },
                          child: Container(
                            child: ClipRRect(
                              child: Image.network(
                                state.cart.products[widget._index].images[0],
                                fit: BoxFit.fill,
                              ),
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(5.0)),
                            ),
                            width: 105,
                            height: 90,
                          ),
                        ),
                        Flexible(
                          child: Column(
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
                                        padding: EdgeInsets.only(
                                            right: 10.0, left: 15.0),
                                        child: GestureDetector(
                                          child: Wrap(
                                            children: <Widget>[
                                              Text(
                                                state
                                                        .cart
                                                        .products[widget._index]
                                                        .name,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                !state
                                                        .cart
                                                        .products[widget._index]
                                                        .status
                                                    ? "(đã bị xóa)"
                                                    : "",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          onTap: () async {
                                            functionBloc.currentState
                                                .navigateToPost(state
                                                .cart
                                                .products[widget._index]
                                                .id);
                                          },
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 10.0,
                                          bottom: 5.0,
                                          left: 15.0,
                                          top: 5.0),
                                      child: Text(
                                        state.cart.products[widget._index]
                                            .description,
                                        maxLines: !state
                                            .cart
                                            .products[widget._index]
                                            .status
                                            ? 1 : 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: colorText, fontSize: 14),
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
                                  Helper().onFormatPrice(state.cart
                                      .products[widget._index].currentPrice),
                                  style: TextStyle(
                                      color: colorActive,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 90,
                    margin:
                        EdgeInsets.only(right: 15.0, top: 15.0, bottom: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Items item = new Items();
                            item =
                                apiBloc.currentState.cart.items[widget._index];
                            item.qty++;
                            updateProductOfCart(
                                apiBloc,
                                apiBloc.currentState.mainUser.id,
                                item,
                                state.cart.products[widget._index]);
                          },
                          child: Container(
                              width: 30,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: colorActive),
                                ),
                              )),
                        ),
                        Text(
                          state.cart.items[widget._index].qty.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Items item = new Items();
                            item =
                                apiBloc.currentState.cart.items[widget._index];
                            if (item.qty > 1) {
                              item.qty--;
                              updateProductOfCart(
                                  apiBloc,
                                  apiBloc.currentState.mainUser.id,
                                  item,
                                  state.cart.products[widget._index]);
                            }
                          },
                          child: Container(
                              width: 30,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          state.cart.items[widget._index].qty ==
                                                  1
                                              ? colorInactive
                                              : colorActive),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: colorInactive, width: 0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await deleteProductOfCart(
                              apiBloc,
                              apiBloc.currentState.mainUser.id,
                              apiBloc.currentState.cart.products[widget._index]
                                  .id);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  right: BorderSide(
                                      color: colorInactive, width: 0.5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(right: 10.0, bottom: 5.0),
                                child: Icon(
                                  FontAwesomeIcons.trashAlt,
                                  size: 17,
                                ),
                              ),
                              Text(
                                'XÓA',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                          height: 40, child: FavoriteItem(widget._index)),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ]));
      },
    );
  }
}
