import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_food_app/const/color_const.dart';

final List<String> imgList = [
  'assets/images/flan.jpg',
  'assets/images/cherry.jpg',
  'assets/images/tiramisu.jpg',
  'assets/images/cheese.jpg'
];

final List child = map<Widget>(imgList, (index, i) {
  return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.asset(
                i,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
              Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Colors.green, Colors.white],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  )),
            ],
          )));
}).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  bool _isFav = true;

  @override
  Widget build(BuildContext context) {
    final basicSlider = CarouselSlider(
      items: child,
      autoPlay: false,
      height: 200,
      updateCallback: (index) {
        setState(() {
          _current = index;
        });
      },
    );
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          margin: EdgeInsets.only(top: 15.0, left: 15.0, bottom: 5.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: map<Widget>(imgList, (index, url) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _current = index;
                        basicSlider.jumpToPage(_current);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.0),
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        border: new Border.all(color: index == _current ? colorActive : colorInactive, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(imgList[index]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _isFav = !_isFav;
                      });
                    },
                    child: Container(
                      child: Icon(
                        Icons.favorite,
                        color: _isFav ? Colors.red : colorInactive,
                      ),
                      margin: EdgeInsets.only(right: 15.0),
                    ),
                  ),
                  Icon(
                    Icons.share,
                    color: colorInactive,
                  )
                ],
              ),
            ],
          ),
        ),
        Stack(children: [
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
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index ? Colors.green : Colors.white),
                  );
                }),
              ))
        ]),
      ],
    );
  }
}
