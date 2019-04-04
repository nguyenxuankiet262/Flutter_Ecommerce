import "package:flutter/material.dart";

class ListUser extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  int itemCount = 10;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 86,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => new Container(
          margin: EdgeInsets.only(left: 16.0, right: index == itemCount ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(100.0))),
                  child: ClipOval(
                    child: Image.asset(
                      index % 2 == 0
                          ? 'assets/images/dog.jpg'
                          : 'assets/images/cat.jpg',
                      fit: BoxFit.cover,
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                ),
                onTap: () {
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  index % 2 == 0 ? 'kiki_123' : 'meowmeow',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
