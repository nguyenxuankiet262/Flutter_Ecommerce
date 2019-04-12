import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'package:flutter_food_app/page/search/hotkey.dart';
import 'list_post.dart';
import 'search_product.dart';

class ProductContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductContentState();
}

class ProductContentState extends State<ProductContent>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
        bloc: BlocProvider.of<SearchInputBloc>(context),
        builder: (context, TextSearchState state) {
          return state.searchInput.isNotEmpty
              ? SearchProduct()
              : Container(
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
                        child: Text(
                          "TỪ KHÓA HOT",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                              fontSize: 17
                          ),
                        ),
                      ),
                      HotkeyContent(1),
                      Container(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Text(
                          "GỢI Ý",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 16.0),
                        child: ListPost(),
                      )
                    ],
                  ));
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
