import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'order_item.dart';

class ListOrder extends StatefulWidget {
  int index;

  ListOrder(this.index);

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
    if (widget.index == 0 || widget.index == 2) {
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
            height: MediaQuery.of(context).size.height / 2,
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
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: itemCount,
                    padding: EdgeInsets.only(top: 5),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderItem()));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: new Card(
                                child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "#154123123112",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                      "8 phút trước",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12.0),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text("Tình trạng:"),
                                      Container(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            widget.index == 0
                                                ? "Mới"
                                                : widget.index == 1
                                                    ? "Mới"
                                                    : widget.index == 2
                                                        ? "Thành công"
                                                        : "Hủy",
                                            style: TextStyle(
                                                color: widget.index == 0
                                                    ? colorActive
                                                    : widget.index == 1
                                                        ? colorActive
                                                        : widget.index == 2
                                                            ? Colors.orange
                                                            : Colors.red,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                  ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
