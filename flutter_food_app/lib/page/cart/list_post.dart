import "package:flutter/material.dart";
import 'cart_item.dart';

class ListCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListCartState();
}

class _ListCartState extends State<ListCart> {
  int itemCount = 6;

  void load() {
    if(this.mounted) {
      setState(() {
        itemCount += 5;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: RefreshIndicator(
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) => CartItem()
        ),
        onRefresh: _refresh,
      ),
    );
  }

  Future<bool> _loadMore() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 1000));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 1000));
    setState(() {
      itemCount = 5;
    });
  }
}
