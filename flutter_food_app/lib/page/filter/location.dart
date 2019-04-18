import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';

class LocationFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LocationFilterState();
}

final formatter = new NumberFormat("###,###,###");

class LocationFilterState extends State<LocationFilter> {
  double _lowerValue = 0;
  double _upperValue = 100;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "KHU VỰC",
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
                        formatter.format(_lowerValue.toInt()) + " km",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(" đến "),
                      Text(
                        _upperValue != 100
                            ? formatter.format(_upperValue.toInt()) + " km"
                            : formatter.format(_upperValue.toInt()) + "+ km",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 16.0),
                child: FlutterSlider(
                  values: [_lowerValue, _upperValue],
                  rangeSlider: true,
                  max: 100,
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
                      Icons.location_on,
                      color: colorActive,
                      size: 20,
                    ),
                  ),
                  rightHandler: FlutterSliderHandler(
                    child: Icon(
                      Icons.location_on,
                      color: colorActive,
                      size: 20,
                    ),
                  ),
                  handlerAnimation: FlutterSliderHandlerAnimation(
                      duration: Duration(milliseconds: 500), scale: 1.5),
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBarColor: colorActive,
                    inactiveTrackBarColor: colorInactive,
                  ),
                ))
          ],
        ));
  }
}
