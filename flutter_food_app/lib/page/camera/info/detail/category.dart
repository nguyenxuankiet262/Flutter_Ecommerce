import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';

class CategoryRadio extends StatefulWidget {
  @override
  createState() {
    return new CategoryRadioState();
  }
}

class CategoryRadioState extends State<CategoryRadio> {
  List<RadioModel> categories = new List<RadioModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories.add(new RadioModel(true, 'assets/images/salad.jpg', 'Rau củ'));
    categories
        .add(new RadioModel(false, 'assets/images/fruit.jpg', 'Trái cây'));
    categories.add(new RadioModel(false, 'assets/images/meat.jpg', 'Thịt'));
    categories.add(new RadioModel(false, 'assets/images/fish.jpg', 'Cá'));
    categories
        .add(new RadioModel(false, 'assets/images/hamburger.jpg', 'Đồ ăn'));
    categories
        .add(new RadioModel(false, 'assets/images/cake.jpg', 'Bánh ngọt'));
    categories.add(new RadioModel(false, 'assets/images/other.jpg', 'Khác'));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        brightness: Brightness.light,
        title: new Text(
          'Lựa chọn loại sản phẩm',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: new ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            //highlightColor: Colors.red,
            splashColor: colorActive,
            onTap: () {
              setState(() {
                categories.forEach((element) => element.isSelected = false);
                categories[index].isSelected = true;
                Future.delayed(new Duration(milliseconds: 400), () {
                  Navigator.pop(context);
                });

              });
            },

            child: new RadioItem(categories[index]),
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: colorInactive,
            width: 1.0,
          ))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                new Container(
                  height: 50.0,
                  width: 50.0,
                  child: ClipRRect(
                      child: Image.asset(
                        _item.image,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0))),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: colorInactive),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.only(left: 10.0),
                  child: new Text(
                      _item.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                    ),
                  ),
                )
              ],
            ),
          ),
          new Container(
            height: 24.0,
            width: 24.0,
            child: new Center(
              child: _item.isSelected
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String image;
  final String text;

  RadioModel(this.isSelected, this.image, this.text);
}
