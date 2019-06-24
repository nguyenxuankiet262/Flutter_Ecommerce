import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/detail_page_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';

class PriceFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PriceFilterState();
}

final formatter = new NumberFormat("###,###,###");


class PriceFilterState extends State<PriceFilter> {
  DetailPageBloc detailPageBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailPageBloc = BlocProvider.of<DetailPageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: detailPageBloc,
      builder: (context, DetailPageState state){
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
                            Helper().onFormatPrice(state.tempMin.toString()),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(" đến "),
                          Text(
                              (state.tempMax / 10000) != 1000
                                ? Helper().onFormatPrice(state.tempMax.toString())
                                : Helper().onFormatPrice(state.tempMax.toString()) + " +",
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
                      values: [(state.tempMin / 10000).toDouble(), (state.tempMax / 10000).toDouble()],
                      rangeSlider: true,
                      max: 1000,
                      min: 0,
                      jump: true,
                      step: 5,
                      tooltip: FlutterSliderTooltip(disabled: true),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        detailPageBloc.changeTempFilter((lowerValue * 10000).toInt(), (upperValue * 10000).toInt(), state.tempCode);
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
      },
    );
  }
}
