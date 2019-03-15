import 'package:flutter/material.dart';

List<String> nameList = [
  'Đánh giá',
  'Theo dõi',
  'Gọi điện'
];

class SettingsAnother extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 180.0,
      margin: EdgeInsets.all(15.0),
      color: Colors.transparent, //could change this to Color(0xFF737373),
      //so you don't have to change MaterialApp canvasColor
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                ),
              )
          ),
          ListView.builder(
            itemCount: nameList.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) =>
                GestureDetector(
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        nameList[index],
                        style: TextStyle(
                            fontSize: 14,
                            color: index != 2 ? Colors.blue : Colors.red,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    switch (index) {
                      case 0:
                        {
                          Navigator.pop(context);
                        }
                        break;
                      case 1:
                        {
                          Navigator.pop(context);
                        }
                        break;
                      case 2:
                        {
                          Navigator.pop(context);
                        }
                        break;
                    }
                  },
                ),
          ),
        ],
      ),
    );
  }
}
