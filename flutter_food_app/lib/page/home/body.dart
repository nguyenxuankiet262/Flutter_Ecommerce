import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:shimmer/shimmer.dart';
import 'slider.dart';
import 'category.dart';
import 'header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';

class BodyContent extends StatefulWidget {
  final Function navigateToPost, navigateToFilter;

  BodyContent(this.navigateToPost, this.navigateToFilter);

  @override
  State<StatefulWidget> createState() => BodyContentState();
}

class BodyContentState extends State<BodyContent>
    with AutomaticKeepAliveClientMixin {
  ScrollController _hideButtonController;
  ApiBloc apiBloc;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshHeaderState> _connectorHeaderKey =
  new GlobalKey<RefreshHeaderState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        BlocProvider.of<BottomBarBloc>(context).changeVisible(false);
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hideButtonController.dispose();
  }

  void navigateToPost() {
    this.widget.navigateToPost();
  }

  void navigateToFilter() {
    this.widget.navigateToFilter();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return new EasyRefresh(
          key: _easyRefreshKey,
          refreshHeader: ConnectorHeader(key: _connectorHeaderKey, header: DeliveryHeader(key: _headerKey)),
          child: CustomScrollView(
            controller: _hideButtonController,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  DeliveryHeader(key: _headerKey)
                ]),
              ),
              SliverList(
                delegate:
                SliverChildListDelegate(<Widget>[
                  state.listMenu.isEmpty
                      ? Shimmer.fromColors(
                    child: Container(
                      height: 200,
                      margin:
                      EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0),
                      color: Colors.white,
                    ),
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                  )
                      : CarouselWithIndicator(),
                  Container(
                      margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Container(
                        child: state.listMenu.isEmpty
                            ? Container(
                          height: 80,
                          width: 80,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder:
                                  (BuildContext context, int index) =>
                                  Shimmer.fromColors(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 16.0,
                                        right: index == 4 ? 16.0 : 0.0,
                                      ),
                                      width: 80.0,
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        border: new Border.all(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[100],
                                  )),
                        )
                            : HeaderHome(
                            this.navigateToPost, this.navigateToFilter),
                      )),
                  Container(
                    child: ListCategory(this.navigateToPost),
                  ),
                ]),
              ),
            ],
          ),
          onRefresh: () async {
            apiBloc.changeMenu([]);
            await new Future.delayed(const Duration(seconds: 1), () {
              fetchMenus(apiBloc);
              BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
            });
          },
        );
      },
    );
  }
}
