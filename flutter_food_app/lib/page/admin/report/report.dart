import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/admin_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/admin/report/list_report.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_unproved.dart';
import 'package:toast/toast.dart';

class AdminReportManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AdminReportManageState();
}

class AdminReportManageState extends State<AdminReportManage> {
  AdminBloc adminBloc;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshHeaderState> _connectorHeaderKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKeyGrid =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshFooterState> _connectorFooterKeyGrid =
      new GlobalKey<RefreshFooterState>();
  int begin = 1;
  int end = 10;
  bool isLoading = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    adminBloc.changeReportList(null);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminBloc = BlocProvider.of<AdminBloc>(context);
    (() async {
      if (await Helper().check()) {
        await fetchReport(adminBloc, "1", "10");
        setState(() {
          isLoading = false;
        });
        fetchAmountReport(adminBloc);
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
    return BlocBuilder(
      bloc: adminBloc,
      builder: (context, AdminState state) {
        return Scaffold(
            appBar: AppBar(
              brightness: Brightness.light,
              elevation: 0.5,
              centerTitle: true,
              title: Container(
                child: new Text(
                  'Báo cáo',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: Container(
                color: Colors.grey.withOpacity(0.3),
                child: EasyRefresh(
                  key: _easyRefreshKey,
                  refreshHeader: ConnectorHeader(
                      key: _connectorHeaderKey,
                      header: DeliveryHeader(key: _headerKey)),
                  refreshFooter: ConnectorFooter(
                      key: _connectorFooterKeyGrid,
                      footer: ClassicsFooter(
                        bgColor: colorBackground,
                        key: _footerKeyGrid,
                      )),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(
                            <Widget>[DeliveryHeader(key: _headerKey)]),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate(<Widget>[
                        isLoading
                            ? ShimmerUnprovedPost()
                            : state.listReports == null
                                ? Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height -
                                        150,
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
                                            "Không có sản phẩm nào",
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
                                : state.listReports.isEmpty
                                    ? Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height -
                                                150,
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
                                              margin:
                                                  EdgeInsets.only(top: 16.0),
                                              child: Text(
                                                "Không có sản phẩm nào",
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
                                    : ListReport()
                      ])),
                      isLoading
                          ? SliverList(
                              delegate: SliverChildListDelegate(<Widget>[]),
                            )
                          : state.listReports == null
                              ? SliverList(
                                  delegate: SliverChildListDelegate(<Widget>[]),
                                )
                              : state.listReports.isEmpty
                                  ? SliverList(
                                      delegate:
                                          SliverChildListDelegate(<Widget>[]),
                                    )
                                  : SliverList(
                                      delegate:
                                          SliverChildListDelegate(<Widget>[
                                        ClassicsFooter(
                                          key: _footerKeyGrid,
                                          loadHeight: 50.0,
                                          bgColor: colorBackground,
                                        )
                                      ]),
                                    )
                    ],
                  ),
                  loadMore: isLoading
                      ? null
                      : state.listReports == null
                          ? null
                          : state.listReports.isEmpty
                              ? null
                              : () async {
                                  if (await Helper().check()) {
                                    if (state.listReports.length == end) {
                                      setState(() {
                                        begin += 10;
                                        end += 10;
                                      });
                                      await fetchReport(adminBloc,
                                          begin.toString(), end.toString());
                                      _footerKeyGrid.currentState.onLoadEnd();
                                    } else {
                                      await new Future.delayed(
                                          const Duration(seconds: 1), () {});
                                      _footerKeyGrid.currentState.onNoMore();
                                      _footerKeyGrid.currentState.onLoadClose();
                                    }
                                  } else {
                                    new Future.delayed(
                                        const Duration(seconds: 1), () {
                                      Toast.show(
                                          "Vui lòng kiểm tra mạng!", context,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.black87);
                                    });
                                  }
                                },
                  onRefresh: () async {
                    if (await Helper().check()) {
                      await new Future.delayed(const Duration(seconds: 1),
                          () async {
                        setState(() {
                          begin = 1;
                          end = 10;
                          isLoading = true;
                        });
                        adminBloc.changeReportList(null);
                        await fetchReport(adminBloc, "1", "10");
                        setState(() {
                          isLoading = false;
                        });
                        fetchAmountReport(adminBloc);
                      });
                    } else {
                      new Future.delayed(const Duration(seconds: 1), () {
                        Toast.show("Vui lòng kiểm tra mạng!", context,
                            gravity: Toast.CENTER,
                            backgroundColor: Colors.black87);
                      });
                    }
                  },
                )));
      },
    );
  }
}
