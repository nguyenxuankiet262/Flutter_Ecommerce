import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'list_follow.dart';

class FollowPage extends StatefulWidget {
  final int value;

  FollowPage({Key key, this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FollowPageState();
}

class FollowPageState extends State<FollowPage> {
  ApiBloc apiBloc;
  bool isLoading = true;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKeyGrid =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshFooterState> _connectorFooterKeyGrid =
      new GlobalKey<RefreshFooterState>();
  int begin = 1;
  int end = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    User user = apiBloc.currentState.mainUser;
    user.listFollowed = null;
    user.listFollowing = null;
    apiBloc.changeMainUser(user);
    (() async {
      if (await Helper().check()) {
        if (widget.value == 1) {
          await fetchFollowedByUser(
              apiBloc, apiBloc.currentState.mainUser.id, "1", "10");
        } else {
          await fetchFollowingByUser(
              apiBloc, apiBloc.currentState.mainUser.id, "1", "10");
        }
        setState(() {
          isLoading = false;
        });
      } else {
        new Future.delayed(const Duration(seconds: 1), () {
          Toast.show("Vui lòng kiểm tra mạng!", context,
              gravity: Toast.CENTER, backgroundColor: Colors.black87);
        });
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          widget.value == 1 ? "Người theo dõi" : "Đang theo dõi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: EasyRefresh(
          key: _easyRefreshKey,
          refreshFooter: ConnectorFooter(
              key: _connectorFooterKeyGrid,
              footer: ClassicsFooter(
                key: _footerKeyGrid,
              )),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  isLoading
                      ? Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height - 150,
                          child: Center(
                              child: SpinKitFadingCircle(
                            color: colorInactive,
                            size: 50.0,
                          )),
                        )
                      : ListFollow(widget.value),
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  ClassicsFooter(
                    key: _footerKeyGrid,
                    loadHeight: 50.0,
                  )
                ]),
              )
            ],
          ),
          loadMore: () async {
            if (await Helper().check()) {
              if (widget.value == 1) {
                if(apiBloc.currentState.mainUser.listFollowed.length == end){
                  await fetchFollowedByUser(
                      apiBloc, apiBloc.currentState.mainUser.id, begin.toString(), end.toString());
                  _footerKeyGrid.currentState
                      .onLoadEnd();
                }
                else{
                  await new Future.delayed(
                      const Duration(
                          seconds: 1),
                          () {});
                  _footerKeyGrid.currentState
                      .onNoMore();
                  _footerKeyGrid.currentState
                      .onLoadClose();
                }

              } else {
                if(apiBloc.currentState.mainUser.listFollowing.length == end){
                  await fetchFollowingByUser(
                      apiBloc, apiBloc.currentState.mainUser.id, begin.toString(), end.toString());
                  _footerKeyGrid.currentState
                      .onLoadEnd();
                }
                else{
                  await new Future.delayed(
                      const Duration(
                          seconds: 1),
                          () {});
                  _footerKeyGrid.currentState
                      .onNoMore();
                  _footerKeyGrid.currentState
                      .onLoadClose();
                }
              }
            } else {
              new Future.delayed(const Duration(seconds: 1), () {
                Toast.show("Vui lòng kiểm tra mạng!", context,
                    gravity: Toast.CENTER, backgroundColor: Colors.black87);
              });
            }
          },
        ),
      ),
    );
  }
}
