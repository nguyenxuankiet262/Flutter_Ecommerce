import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/admin_state.dart';
import 'package:flutter_food_app/common/state/loading_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';

class ListSearchUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListSearchUserState();
}

class _ListSearchUserState extends State<ListSearchUser> with AutomaticKeepAliveClientMixin{
  LoadingBloc loadingBloc;
  SearchInputBloc searchInputBloc;
  AdminBloc adminBloc;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKeyGrid =
  new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshFooterState> _connectorFooterKeyGrid =
  new GlobalKey<RefreshFooterState>();
  int begin = 0;
  int end = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminBloc = BlocProvider.of(context);
    searchInputBloc = BlocProvider.of<SearchInputBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: loadingBloc,
      builder: (context, LoadingState state) {
        return BlocBuilder(
          bloc: adminBloc,
          builder: (context, AdminState adminState) {
            return state.loadingSearch
                ? Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
                child: ListView(
                  children: <Widget>[
                    Container(
                        height:
                        MediaQuery.of(context).size.height -
                            250,
                        child: Center(
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50.0,
                            )))
                  ],
                ))
            : adminState.listSearchUser == null
                ? Container(
              width: double.infinity,
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    const IconData(0xe900,
                        fontFamily: 'box'),
                    size: 150,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Không tìm thấy người dùng",
                      style: TextStyle(
                        color: colorInactive,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Chúc bạn một ngày vui vẻ!",
                      style: TextStyle(
                        color: colorInactive,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
                : adminState.listSearchUser.isEmpty
                ? Container(
              width: double.infinity,
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    const IconData(0xe900,
                        fontFamily: 'box'),
                    size: 150,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Không tìm thấy người dùng",
                      style: TextStyle(
                        color: colorInactive,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Chúc bạn một ngày vui vẻ!",
                      style: TextStyle(
                        color: colorInactive,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
                : Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: new EasyRefresh(
                  key: _easyRefreshKey,
                  refreshFooter: ConnectorFooter(
                      key: _connectorFooterKeyGrid,
                      footer: ClassicsFooter(
                        key: _footerKeyGrid,
                      )),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(<
                            Widget>[
                  ListView.builder(
                  shrinkWrap: true,
                    itemCount: adminState.listSearchUser.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => Container(
                        padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0, bottom: index == adminState.listSearchUser.length - 1 ? 32 : 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => InfoAnotherPage(adminState.listSearchUser[index].id)),
                                    );
                                  },
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: colorInactive, width: 0.5),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  adminState.listSearchUser[index].avatar
                                              )
                                          )
                                      ),
                                      child: adminState.listSearchUser[index].status
                                          ? adminState.listSearchUser[index].isInReview.status
                                          ? Stack(
                                        children: <Widget>[
                                          Container(
                                            height: 50,
                                            width: 50,
                                            color: Colors.black54,
                                          ),
                                          Positioned(
                                            bottom: 2,
                                            right: 1,
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.blue,
                                            ),
                                          )
                                        ],
                                      )
                                          : Container()
                                          : Stack(
                                        children: <Widget>[
                                          Container(
                                            height: 50,
                                            width: 50,
                                            color: Colors.black54,
                                          ),
                                          Positioned(
                                            bottom: 2,
                                            right: 1,
                                            child: Icon(
                                              Icons.lock,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 16.0, top: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => InfoAnotherPage(adminState.listSearchUser[index].id)),
                                            );
                                          },
                                          child: Text(
                                            adminState.listSearchUser[index].name,
                                            style: TextStyle(
                                                fontFamily: "Ralway",
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Text(
                                            adminState.listSearchUser[index].username + " đã tham gia " + Helper().timeAgo(adminState.listSearchUser[index].day),
                                            style: TextStyle(
                                                fontFamily: "Ralway",
                                                fontSize: 12,
                                                color: colorInactive,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
                            PopupMenuButton<int>(
                              onSelected: (int result) async {
                                if(result == 1){
                                  if(!adminState.listSearchUser[index].isInReview.status){
                                    int check = await updateInReviewUserInSearch(adminBloc, adminState.listSearchUser[index].id, true, index);
                                    if(check == 1){
                                      Toast.show("Đã chuyển " + adminState.listSearchUser[index].username + " sang Xem xét!", context);
                                    }
                                    else if(check == 0){
                                      Toast.show("Không thành công!", context);
                                    }
                                    else{
                                      Toast.show("Lỗi hệ thống!", context);
                                    }
                                  }
                                  else{
                                    int check = await updateInReviewUserInSearch(adminBloc, adminState.listSearchUser[index].id, false, index);
                                    if(check == 1){
                                      Toast.show("Đã tắt Xem xét " + adminState.listSearchUser[index].username + "!", context);
                                    }
                                    else if(check == 0){
                                      Toast.show("Không thành công!", context);
                                    }
                                    else{
                                      Toast.show("Lỗi hệ thống!", context);
                                    }
                                  }
                                }
                              },
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: Text(!adminState.listSearchUser[index].isInReview.status
                                      ? 'Chuyển sang đang xem xét'
                                      : 'Tắt chế độ xem xét',
                                    style: TextStyle(
                                      fontFamily: "Ralway",
                                    ),
                                  ),
                                ),
                                PopupMenuItem<int>(
                                  value: 2,
                                  child: Text('Khóa tài khoản',
                                    style: TextStyle(
                                      fontFamily: "Ralway",
                                    ),
                                  ),
                                ),
                              ],
                              tooltip: "Chức năng",
                            )
                          ],
                        )
                    ),
                  )
                        ]),
                      ),
                      adminState.listSearchUser == null
                      ?SliverList(
                        delegate:
                        SliverChildListDelegate(
                            <Widget>[]),
                      )
                      : adminState.listSearchUser.isEmpty
                          ? SliverList(
                        delegate:
                        SliverChildListDelegate(
                            <Widget>[]),
                      )
                          : SliverList(
                        delegate:
                        SliverChildListDelegate(<
                            Widget>[
                          ClassicsFooter(
                            key: _footerKeyGrid,
                            loadHeight: 50.0,
                            bgColor: colorBackground,
                          )
                        ]),
                      )
                    ],
                  ),
                  loadMore: adminState.listSearchUser == null
                  ? null
                  : adminState.listSearchUser.isEmpty
                      ? null
                      : () async {
                    if (await Helper().check()) {
                      if (adminState.listSearchUser.length == end) {
                        setState(() {
                          begin += 10;
                          end += 10;
                        });
                        await fetchSearchUserList(adminBloc, loadingBloc, searchInputBloc
                            .currentState
                            .searchInput , begin.toString(), end.toString());
                        await
                        _footerKeyGrid.currentState
                            .onLoadEnd();
                      } else {
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
                      new Future.delayed(
                          const Duration(seconds: 1),
                              () {
                            Toast.show(
                                "Vui lòng kiểm tra mạng!",
                                context,
                                gravity: Toast.CENTER,
                                backgroundColor:
                                Colors.black87);
                          });
                    }
                  },
                ));
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
