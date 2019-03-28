import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'list_post.dart';

class HeaderDetail extends StatefulWidget {
  int index;
  Function callback;

  HeaderDetail(this.callback, this.index);

  @override
  State<StatefulWidget> createState() => HeaderDetailState();
}

class HeaderDetailState extends State<HeaderDetail> {
  String title = "Tất cả";
  int _index = 0;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _fragments = new List.generate(listMenu[widget.index].childMenu.length, (index) {
      return new ListPost(widget.callback);
    });
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: listMenu[widget.index].childMenu.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        isLoading = true;
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          setState(() {
                            isLoading = false;
                          });
                        });
                        _index = index;

                        title = listMenu[widget.index].childMenu[index].name;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: index == listMenu[widget.index].childMenu.length - 1 ? 16.0 : 0.0),
                      width: 80.0,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(
                            color: index == 0 ? colorActive : colorInactive),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: ClipRRect(
                                child: Image.asset(
                                  listMenu[widget.index]
                                      .childMenu[index]
                                      .image,
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(10.0))),
                            width: 80,
                            height: 100,
                          ),
                          Center(
                              child: Text(
                                listMenu[widget.index].childMenu[index].name,
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
          isLoading
              ? Container(
              height: MediaQuery.of(context).size.height / 2,
              color: colorBackground,
              child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(colorActive),
                  )))
              : _fragments[_index],
        ],
      ),
      color: colorBackground,
    );
  }
}
