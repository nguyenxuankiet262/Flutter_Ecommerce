import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_cart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'cart_item.dart';

class ListCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListCartState();
}

class _ListCartState extends State<ListCart> {
  int itemCount = 6;
  ScrollController _hideButtonController;
  bool isLoading = true;

  void load() {
    if (this.mounted) {
      setState(() {
        itemCount += 5;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        isLoading = false;
      });
    });
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        BlocProvider.of<BottomBarBloc>(context).changeVisible(false);
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hideButtonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading
        ? SpinKitRotatingCircle(
            color: colorActive,
            size: 50.0,
          )
        : new ListView.builder(
            controller: _hideButtonController,
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) => CartItem(index));
  }
}
