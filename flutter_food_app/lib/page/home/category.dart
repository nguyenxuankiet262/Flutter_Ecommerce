import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_post_horiz.dart';
import 'list_post.dart';
import 'package:flutter_food_app/model/menu.dart';

class ListCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  List<Menu> listMenu = [
    Menu("Mới nhất", 'assets/images/discount.jpg'),
    Menu('Yêu thích nhất', 'assets/images/favorite.png'),
  ];
  ApiBloc apiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  new Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 5.0),
                              child: index == 0
                                  ? new Icon(
                                      const IconData(0xe900, fontFamily: 'new'),
                                      color: Colors.red,
                                      size: 24,
                                    )
                                  : new Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                            ),
                            Text(
                              listMenu[index].name.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  index == 0
                      ? Container(
                          child: state.tenNewest == null
                              ? ShimmerPostHoriz()
                              : ListPost(index),
                        )
                      : Container(
                          child: state.tenMostFav == null
                              ? ShimmerPostHoriz()
                              : ListPost(index),
                        ),
                ],
              ),
        );
      },
    );
  }
}
