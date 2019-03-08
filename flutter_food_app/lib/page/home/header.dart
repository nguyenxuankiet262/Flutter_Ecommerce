import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';

List<String> image = [
  'assets/images/discount.jpg',
  'assets/images/favorite.png',
  'assets/images/salad.jpg',
  'assets/images/fruit.jpg',
  'assets/images/meat.jpg',
  'assets/images/fish.jpg',
  'assets/images/hamburger.jpg',
  'assets/images/cake.jpg',
  'assets/images/other.jpg',
];

List<String> name = [
  'Ưu đãi',
  'Nổi bật',
  'Rau củ',
  'Trái cây',
  'Thịt',
  'Cá',
  'Đồ ăn',
  'Bánh ngọt',
  'Khác',
];

class HeaderHome extends StatefulWidget{
  Function callback;
  HeaderHome(this.callback);
  @override
  State<StatefulWidget> createState() => HeaderHomeState();
}

class HeaderHomeState extends State<HeaderHome>{
  void _gotoDetailScreen(){
    this.widget.callback();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: image.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: (){
            _gotoDetailScreen();
          },
          child: Container(
            margin: EdgeInsets.all(5.0),
            width: 90.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
              borderRadius:
              BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      child: Image.asset(
                        image[index],
                        fit: BoxFit.fill,
                      ),
                      borderRadius: new BorderRadius.all(
                          Radius.circular(5.0))),
                  width: 130,
                  height: 100,
                ),
                Center(
                    child: Text(
                      name[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
      height: 70,
      color: Colors.white,
    );
  }
}