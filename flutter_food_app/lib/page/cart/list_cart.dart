import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/loading_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_cart.dart';
import 'cart_item.dart';

class ListCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListCartState();
}

class _ListCartState extends State<ListCart> {
  ApiBloc apiBloc;
  LoadingBloc loadingBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: loadingBloc,
      builder: (context, LoadingState loadinState) {
        return BlocBuilder(
          bloc: apiBloc,
          builder: (context, ApiState apiState) {
            return loadinState.loadingCart
                ? ShimmerCart()
                : apiState.mainUser == null
                    ? ShimmerCart()
                    : apiState.cart == null || apiState.cart.products.isEmpty
                        ? Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height - 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.remove_shopping_cart,
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
                        : ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              new ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: apiState.cart.items.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          CartItem(index)),
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                height: 100,
                                color: colorBackground.withOpacity(0),
                              )
                            ],
                          );
          },
        );
      },
    );
  }
}
