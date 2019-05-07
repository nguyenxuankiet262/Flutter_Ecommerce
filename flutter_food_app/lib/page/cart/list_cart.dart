import "package:flutter/material.dart";
import 'package:flutter_food_app/page/shimmer/shimmer_cart.dart';
import 'cart_item.dart';

class ListCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListCartState();
}

class _ListCartState extends State<ListCart> {
  int itemCount = 6;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading
        ? ShimmerCart()
        : new ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) => CartItem(index));
  }
}
