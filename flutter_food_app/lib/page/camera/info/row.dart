import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_camera_bloc.dart';
import 'package:flutter_food_app/common/state/detail_camera.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class RowLayout extends StatefulWidget {
  final int _index;

  RowLayout(this._index);

  @override
  State<StatefulWidget> createState() => RowLayoutState();
}

class RowLayoutState extends State<RowLayout> {
  MoneyMaskedTextController controller;
  MoneyMaskedTextController controller1;
  DetailCameraBloc blocProvider;
  ApiBloc apiBloc;

  @override
  void initState() {
    super.initState();
    blocProvider = BlocProvider.of<DetailCameraBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    controller = new MoneyMaskedTextController();
    controller1 = new MoneyMaskedTextController();
    controller.addListener(_changePriceOriginal);
    controller1.addListener(_changePriceDiscount);
  }

  _changePriceOriginal() {
    setState(() {
      blocProvider.changePriceBefore(controller.text);
    });
  }

  _changePriceDiscount() {
    setState(() {
      blocProvider.changePriceAfter(controller1.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget._index != 1 && widget._index != 2
        ? BlocBuilder(
            bloc: blocProvider,
            builder: (context, DetailCameraState state) {
              return Text(
                widget._index == 0
                    ? apiBloc.currentState.listMenu[state.indexCategory]
                        .listChildMenu[state.indexChildCategory].name
                    : state.unit,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: colorInactive, fontSize: 14, fontFamily: "Ralway"),
                textAlign: TextAlign.end,
              );
            },
          )
        : widget._index == 1
            ? TextField(
                controller: controller,
                textAlign: TextAlign.right,
                maxLength: 11,
                keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                decoration: InputDecoration(
                  counterStyle: TextStyle(fontSize: 0),
                  suffixText: '₫',
                  suffixStyle: TextStyle(
                      color: colorInactive, fontSize: 14, fontFamily: "Ralway"),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                    color: colorInactive, fontSize: 14, fontFamily: "Ralway"),
              )
            : TextField(
                controller: controller1,
                textAlign: TextAlign.right,
                maxLength: 11,
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(
                  counterStyle: TextStyle(fontSize: 0),
                  suffixText: '₫',
                  suffixStyle: TextStyle(
                      color: colorInactive, fontSize: 14, fontFamily: "Ralway"),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                    color: colorInactive, fontSize: 14, fontFamily: "Ralway"),
              );
  }
}
