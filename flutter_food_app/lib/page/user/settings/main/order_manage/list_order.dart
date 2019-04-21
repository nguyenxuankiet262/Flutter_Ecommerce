import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'order_item.dart';

class ListOrder extends StatefulWidget {
  final int index;
  final bool isSellOrder;

  ListOrder(this.index, this.isSellOrder);

  @override
  State<StatefulWidget> createState() => ListOrderState();
}

class ListOrderState extends State<ListOrder>
    with AutomaticKeepAliveClientMixin {
  int itemCount;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
      if (widget.index == 0) {
      itemCount = 10;
    } else if (widget.index == 1) {
      itemCount = 2;
    } else {
      itemCount = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading
        ? Container(
            height: MediaQuery.of(context).size.height,
            color: colorBackground,
            child: Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(colorActive),
            )))
        : Container(
            color: colorBackground,
            child: itemCount == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage("assets/images/icon_heartbreak.png"),
                          ),
                        ),
                        height: 200,
                        width: 200,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Text('Chưa có bài viết!'),
                      ),
                    ],
                  )
                : StaggeredGridView.countBuilder(
                    padding: EdgeInsets.only(top: 5),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    itemCount: itemCount,
                    itemBuilder: (BuildContext context, int index) =>
                        OrderItem(widget.index, widget.isSellOrder),
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(2)),
          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
