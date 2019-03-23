import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_food_app/page/user/info.dart';
import 'package:toast/toast.dart';

class PostBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostBodyState();
}

class PostBodyState extends State<PostBody> {
  bool _isFav = true;
  int count = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 12.0, left: 15.0, right: 15.0, top: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bánh tiramisu thơm ngon đây cả nhà ơi.',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontFamily: "Ralway",
                    fontWeight: FontWeight.bold
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10.0,),
                          child: Text(
                            '60.000 VNĐ',
                            style: TextStyle(
                              color: colorActive,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '120.000 VNĐ',
                          style: TextStyle(
                              color: colorInactive,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 15.0),
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: Icon(
                              Icons.share,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _isFav = !_isFav;
                              if(_isFav){
                                Toast.show("Đã lưu vào mục yêu thích", context);
                                count ++;
                              }
                              else{
                                Toast.show("Đã xóa khỏi mục yêu thích", context);
                                count --;
                              }
                            });
                          },
                          child: Icon(
                            Icons.favorite,
                            color: _isFav ? Colors.red : colorInactive,
                            size: 20,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2.0, bottom: 1.0),
                          child: Text(
                            "(" + count.toString() + ")",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Ralway"
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ),

            ],
          )
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Overall Rating',
                          style: TextStyle(fontSize: 17, color: colorInactive),
                        ),
                        Text(
                          '4.5',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: colorActive),
                        ),
                        SmoothStarRating(
                          starCount: 5,
                          size: 22.0,
                          rating: 5,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'GIỚI THIỆU',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          margin: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              color: colorComment,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(color: colorComment)),
                          child: Center(
                              child: Text(
                                '20 giờ',
                                style: TextStyle(
                                  color: colorInactive,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      'Còn gì tuyệt vời hơn khi kết hợp thưởng thức đồ uống của bạn cùng với những chiếc bánh ngọt ngon tinh tế được làm thủ công ngay tại bếp bánh của Highlands Coffee. Những chiếc bánh của chúng tôi mang hương vị đặc trưng của ẩm thực Việt và còn là sự Tận Tâm, gửi gắm mà chúng tôi dành cho Quý khách hàng.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.only(bottom: 5.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'THÔNG TIN NGƯỜI ĐĂNG',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: GestureDetector(
                      child: Text(
                        'xuankiet262',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colorActive
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(true)));
                      },
                    ),
                  ),
                  SmoothStarRating(
                    starCount: 5,
                    size: 18.0,
                    rating: 5,
                    color: Colors.yellow,
                    borderColor: Colors.yellow,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        Icons.home,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '123 Đường lên đỉnh Olympia F.15 Q.1 TP.Hồ Chí Minh.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        Icons.phone,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '+84 123 456 789',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
