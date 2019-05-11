import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';

class RatingFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RatingFilterState();
}

class RatingFilterState extends State<RatingFilter> {
  List<bool> options = [
    true,
    true,
    true,
    true,
    true,
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: tabsRating.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                int count = 0;
                int _index;
                for (int i = 0; i < options.length; i++) {
                  if (!options[i]) {
                    count++;
                  }
                  else{
                    _index = i;
                  }
                }
                if (count != options.length - 1 || _index != index) {
                  setState(() {
                    options[index] = !options[index];
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 16.0),
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                decoration: BoxDecoration(
                    color: options[index] ? colorActive : Colors.white,
                    border: Border.all(
                      color: options[index] ? colorActive : colorInactive,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Text(
                        tabsRating[index],
                        style: TextStyle(
                            color: options[index] ? Colors.white : colorInactive,
                            fontSize: 12,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 1.0),
                        child: Icon(
                          Icons.star,
                          color: options[index] ? Colors.white : colorInactive,
                          size: 15,
                        ),
                      )
                    ],
                  )
                ),
              ),
            ));
  }
}
