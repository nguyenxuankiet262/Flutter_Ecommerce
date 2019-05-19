import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:toast/toast.dart';

class AddToCart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AddToCartState();
}

class AddToCartState extends State<AddToCart>{
  int _count = 1;
  ApiBloc apiBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState apiState){
        return Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 85,
                  width: 130,
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(apiState.product.images[0]),
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
                          width: MediaQuery.of(context).size.width - 170,
                          child: Text(
                            apiState.product.name,
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
                            Helper().onFormatPrice(apiState.product.currentPrice),
                            style: TextStyle(
                              color: colorActive,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              Helper().onFormatPrice(apiState.product.initPrice),
                              style: TextStyle(
                                  color: colorInactive,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: Text(
                                Helper().onCalculatePercentDiscount(apiState.product.initPrice, apiState.product.currentPrice),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
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
                margin: EdgeInsets.only( bottom: 20.0),
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
                              fontSize: 14
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
                height: 40,
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
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}