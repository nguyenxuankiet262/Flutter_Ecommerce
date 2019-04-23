import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_camera_bloc.dart';
import 'package:flutter_food_app/common/state/detail_camera.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class RowLayout extends StatefulWidget {
  final int _index;

  RowLayout(this._index);

  @override
  State<StatefulWidget> createState() => RowLayoutState();
}

class RowLayoutState extends State<RowLayout> {
  String priceOriginal = "";
  String priceDiscount = "";
  MaskedTextController controller;
  MaskedTextController controller1;
  List<String> nameOption;
  DetailCameraBloc blocProvider;

  @override
  void initState() {
    super.initState();
    blocProvider = BlocProvider.of<DetailCameraBloc>(context);
    controller = new MaskedTextController(
        mask: '000.000.000', text: blocProvider.currentState.priceBefore);
    controller1 = new MaskedTextController(
        mask: '000.000.000', text: blocProvider.currentState.priceAfter);
    controller.addListener(_changePriceOriginal);
    controller1.addListener(_changePriceDiscount);
    nameOption = [
      listMenu[blocProvider.currentState.indexCategory]
          .childMenu[blocProvider.currentState.indexChildCategory]
          .name,
      "100.000.000 VNĐ",
      "50.000 VNĐ",
      "Kg",
      "123 Đường lên đỉnh Olympia F.15 Q.TB, TP.HCM",
      '+84 123 456 789',
    ];
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }

  _changePriceOriginal() {
    setState(() {
      priceOriginal = controller.text;
      blocProvider.changePriceBefore(controller.text);
    });
  }

  _changePriceDiscount() {
    setState(() {
      priceDiscount = controller1.text;
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
                    ? listMenu[state.indexCategory]
                        .childMenu[state.indexChildCategory]
                        .name
                    : nameOption[widget._index],
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
                maxLength: 11,
                onSubmitted: (value) {
                  setState(() {
                    controller1.text = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    controller1.text = value;
                  });
                },
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(
                  counterStyle: TextStyle(fontSize: 0),
                  suffixText: 'VNĐ',
                  suffixStyle: TextStyle(
                      color: colorInactive, fontSize: 14, fontFamily: "Ralway"),
                  border: InputBorder.none,
                ),
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: colorInactive, fontSize: 14, fontFamily: "Ralway"),
              )
            : TextField(
                controller: controller1,
                maxLength: 11,
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(
                  counterStyle: TextStyle(fontSize: 0),
                  suffixText: 'VNĐ',
                  suffixStyle: TextStyle(
                      color: colorInactive, fontSize: 14, fontFamily: "Ralway"),
                  border: InputBorder.none,
                ),
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: colorInactive, fontSize: 14, fontFamily: "Ralway"),
              );
  }
}
