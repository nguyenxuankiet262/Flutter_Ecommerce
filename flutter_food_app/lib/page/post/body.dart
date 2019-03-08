import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_food_app/page/user/another_user/info.dart';

class PostBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostBodyState();
}

class PostBodyState extends State<PostBody> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: colorInactive,
            ),
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
                          style: TextStyle(fontSize: 25, color: colorInactive),
                        ),
                        Text(
                          '4.5',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: colorActive),
                        ),
                        SmoothStarRating(
                          starCount: 5,
                          size: 30.0,
                          rating: 5,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'GIỚI THIỆU',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      'Còn gì tuyệt vời hơn khi kết hợp thưởng thức đồ uống của bạn cùng với những chiếc bánh ngọt ngon tinh tế được làm thủ công ngay tại bếp bánh của Highlands Coffee. Những chiếc bánh của chúng tôi mang hương vị đặc trưng của ẩm thực Việt và còn là sự Tận Tâm, gửi gắm mà chúng tôi dành cho Quý khách hàng.',
                      style: TextStyle(fontSize: 16),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '120.000 VNĐ',
                            style: TextStyle(
                                color: colorInactive,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: Text(
                              '-50%',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 100,
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
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.bookmark,
                size: 50.0,
                color: colorBookmark,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 12.0, left: 12.0),
                child: Icon(
                  Icons.star,
                  size: 25.0,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.all(5.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: colorInactive,
            ),
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
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: colorActive
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InfoUserPage()));
                      },
                    ),
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
                          fontSize: 16,
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
                          fontSize: 16,
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
