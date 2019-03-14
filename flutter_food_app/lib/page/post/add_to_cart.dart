import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:toast/toast.dart';

class AddToCart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AddToCartState();
}

class AddToCartState extends State<AddToCart>{
  int _count = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 100,
              width: 150,
              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/flan.jpg'),
                  )
              ),
            ),
            Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 190,
                      child: Text(
                        'Bánh tiramisu thơm ngon đây cả nhà ơi',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        '60.000 VNĐ',
                        style: TextStyle(
                          color: colorActive,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '120.000 VNĐ',
                          style: TextStyle(
                              color: colorInactive,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            '-50%',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: Center(
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                    color: colorInactive.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
              ),
            )
        ),
        Column(
          children: <Widget>[
            Text(
              'CHỌN SỐ LƯỢNG',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: Center(
                    child: Text(
                      _count.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          if(_count > 1) {
                            _count--;
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(13.0),//I
                        margin: EdgeInsets.only(right: 100.0),// used some padding without fixed width and height
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,// You can use like this way or like the below line
                            //borderRadius: new BorderRadius.circular(30.0),
                            color: Colors.white,
                            border: Border.all(color: colorInactive)
                        ),
                        child: Text(
                          "-",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: _count == 1 ? colorInactive : colorActive
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _count++;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),//I used some padding without fixed width and height
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,// You can use like this way or like the below line
                            //borderRadius: new BorderRadius.circular(30.0),
                            color: Colors.white,
                            border: Border.all(color: colorInactive)
                        ),
                        child: Text(
                          "+",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: colorActive
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            Toast.show("Đã thêm vào giỏ hàng", context);
          },
          child: Container(
            width: 220,
            height: 50,
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                color: colorActive,
                borderRadius: BorderRadius.all(Radius.circular(50.0))
            ),
            child: Center(
              child: Text(
                "THÊM VÀO GIỎ HÀNG",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}