import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/model/child_menu.dart';

class HeaderDetail extends StatefulWidget {
  Function navigateToPost, navigateToUserPage;
  List<ChildMenu> childMenu;

  HeaderDetail(this.childMenu);

  @override
  State<StatefulWidget> createState() => HeaderDetailState();
}

class HeaderDetailState extends State<HeaderDetail> {
  String title = "Tất cả";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.childMenu.length + 1,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        if (index != 0) {
                          title = widget.childMenu[index - 1].name;
                        } else {
                          title = "Tất cả";
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      width: 80.0,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(
                            color: index == 0 ? colorActive : colorInactive),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: index == 0
                          ? Center(
                              child: Text(
                                "Tất cả",
                                style: TextStyle(
                                  color: colorActive,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : Stack(
                              children: <Widget>[
                                Container(
                                  child: ClipRRect(
                                      child: Image.asset(
                                        widget.childMenu[index - 1].image,
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(10.0))),
                                  width: 80,
                                  height: 100,
                                ),
                                Center(
                                    child: Text(
                                  widget.childMenu[index - 1].name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            ),
                    ),
                  ),
            ),
          ),
          Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: colorInactive, width: 0.5)),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
      height: 140,
      color: colorBackground,
    );
  }
}
