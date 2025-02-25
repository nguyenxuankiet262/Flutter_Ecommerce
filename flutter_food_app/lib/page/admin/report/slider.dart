import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/admin_state.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class SliderReport extends StatefulWidget {
  final int _index;
  SliderReport(this._index);
  @override
  SliderReportState createState() => SliderReportState();
}

class SliderReportState extends State<SliderReport> {
  int _current = 0;
  AdminBloc adminBloc;
  List child;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminBloc = BlocProvider.of<AdminBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: adminBloc,
      builder: (context, AdminState state){
        child = map<Widget>(state.listReports[widget._index].product.images, (index, i) {
          return Stack(
            children: <Widget>[
              Image.network(
                i,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ],
          );
        }).toList();
        final basicSlider = CarouselSlider(
          items: child,
          autoPlay: false,
          enableInfiniteScroll: false,
          height: 300,
          viewportFraction: 1.0,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        );
        return Container(
          child: Stack(children: [
            basicSlider,
            Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(state.listReports[widget._index].product.images, (index, url) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index ? Colors.green : Colors.white),
                    );
                  }),
                )),
            Helper().onCalculatePercentDiscount(state.listReports[widget._index].product.initPrice, state.listReports[widget._index].product.currentPrice) == "0%"
                ? Container()
                : Positioned(
              top: 0.0,
              right: 0.0,
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.9),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'GIẢM',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 12
                          ),
                        ),
                        Text(
                          Helper().onCalculatePercentDiscount(state.listReports[widget._index].product.initPrice, state.listReports[widget._index].product.currentPrice),
                          style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),
          ]),
        );
      },
    );
  }
}
