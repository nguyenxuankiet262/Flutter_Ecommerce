import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';

List<String> imgList = [];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

final List child = map<Widget>(imgList, (index, i) {
  return Stack(
    children: <Widget>[
      Image.network(
        i,
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      ),
    ],
  );
}).toList();

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  ApiBloc apiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    imgList = [];
    for(int i = 0; i < apiBloc.currentState.listBanner.length; i++){
      imgList.add(apiBloc.currentState.listBanner[i].img);
    }
  }


  @override
  Widget build(BuildContext context) {
    final basicSlider = Container(
      margin: EdgeInsets.only(right: 5.0, left: 5.0),
        child: CarouselSlider(
      items: child,
      autoPlay: true,
      height: 200,
      viewportFraction: 1.0,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
    ));
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: Stack(children: [
        basicSlider,
        Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(imgList, (index, url) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index ? Colors.green : Colors.white),
                );
              }),
            )),
      ]),
    );
  }
}
