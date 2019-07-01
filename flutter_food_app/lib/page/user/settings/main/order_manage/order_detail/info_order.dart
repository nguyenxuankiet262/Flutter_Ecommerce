import 'package:flutter/material.dart';
import 'package:flutter_food_app/api/model/order.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InforOrder extends StatefulWidget {
  final Order order;

  InforOrder(this.order);

  @override
  State<StatefulWidget> createState() => InforOrderState();
}

class InforOrderState extends State<InforOrder> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: widget.order.listProduct.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Container(
              margin: EdgeInsets.only(right: 5.0, left: 5.0),
              child: Card(
                color: Colors.white,
                elevation: 1.5,
                child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Column(children: <Widget>[
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            width: MediaQuery.of(context).size.width - 40,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Post(widget
                                                .order
                                                .listProduct[index]
                                                .id)));
                                  },
                                  child: Container(
                                    child: ClipRRect(
                                      child: Image.network(
                                        widget
                                            .order.listProduct[index].images[0],
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    width: 105,
                                    height: 105,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 145,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 10.0, left: 15.0),
                                        child: Wrap(
                                          children: <Widget>[
                                            Text(
                                              widget.order.listProduct[index].name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              widget
                                                  .order.listProduct[index].status
                                                  ? " (đã bị xóa)" : "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                color: Colors.red
                                              ),
                                            ),
                                          ],
                                        )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 10.0, left: 15.0),
                                        child: Text(
                                          widget.order.listProduct[index]
                                              .description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: colorText, fontSize: 12,
                                             fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              right: 10.0,
                                              bottom: 5.0,
                                              left: 15.0,
                                              top: 5.0),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 5.0),
                                                child: Icon(
                                                  FontAwesomeIcons.carrot,
                                                  size: 13,
                                                ),
                                              ),
                                              Text(
                                                "Số lượng: ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                                child: Text(
                                                  widget
                                                      .order.product[index].qty
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: colorActive,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0),
                                                ),
                                              ),
                                              Text(
                                                "kg",
                                                style: TextStyle(
                                                    color: colorActive,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 12.0),
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              right: 10.0,
                                              bottom: 5.0,
                                              left: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 5.0),
                                                child: Icon(
                                                  FontAwesomeIcons.dollarSign,
                                                  size: 13,
                                                ),
                                              ),
                                              Text(
                                                "Giá: ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                                child: Text(
                                                  Helper().onFormatPrice(widget
                                                      .order
                                                      .listProduct[index]
                                                      .currentPrice),
                                                  style: TextStyle(
                                                      color: colorActive,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 4.0),
                                                child: Text(
                                                  "/",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0),
                                                ),
                                              ),
                                              Text(
                                                "kg",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 12.0),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 10.0, right: 10.0, left: 10.0, bottom: 5.0),
                        decoration: BoxDecoration(
                          border: Border(
                              top:
                                  BorderSide(color: colorInactive, width: 0.5)),
                        ),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "TỔNG: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  Helper().onFormatPrice((double.parse(widget
                                              .order
                                              .listProduct[index]
                                              .currentPrice) *
                                          widget.order.product[index].qty)
                                      .toString()),
                                  style: TextStyle(
                                      color: colorActive,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])),
              ),
            ));
  }
}
