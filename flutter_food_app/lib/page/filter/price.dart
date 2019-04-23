import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';

class PriceFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PriceFilterState();
}

final formatter = new NumberFormat("###,###,###");


class PriceFilterState extends State<PriceFilter> {
  double _lowerValue = 0;
  double _upperValue = 1000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "GIÁ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "từ ",
                      ),
                      Text(
                        formatter.format((_lowerValue * 10000).toInt()) + " VNĐ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(" đến "),
                      Text(
                        _upperValue != 1000
                            ? formatter.format((_upperValue * 10000).toInt()) + " VNĐ"
                            : formatter.format((_upperValue * 10000).toInt()) + "+ VNĐ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: FlutterSlider(
                  values: [_lowerValue, _upperValue],
                  rangeSlider: true,
                  max: 1000,
                  min: 0,
                  jump: true,
                  step: 5,
                  tooltip: FlutterSliderTooltip(disabled: true),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    setState(() {
                      _lowerValue = lowerValue;
                      _upperValue = upperValue;
                    });
                  },
                  handler: FlutterSliderHandler(
                    child: Icon(
                      Icons.attach_money,
                      color: colorActive,
                      size: 20,
                    ),
                  ),
                  rightHandler: FlutterSliderHandler(
                    child: Icon(
                      Icons.attach_money,
                      color: colorActive,
                      size: 20,
                    ),
                  ),
                  handlerAnimation: FlutterSliderHandlerAnimation(
                      duration: Duration(milliseconds: 500), scale: 1.5),
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBarColor: colorActive,
                    inactiveDisabledTrackBarColor: colorInactive,
                  ),
                ))
          ],
        ));
  }
}
