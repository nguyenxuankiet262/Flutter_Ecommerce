import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/helper/my_behavior.dart';
import 'package:flutter_food_app/common/state/admin_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/admin/feedback/feedback.dart';
import 'package:flutter_food_app/page/admin/post/post.dart';
import 'package:flutter_food_app/page/admin/report/report.dart';
import 'package:flutter_food_app/page/admin/member/user_manage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage> {
  final adminBloc = AdminBloc();
  UserBloc userBloc;
  bool onTap = false;
  List<IconData> listIcons = [
    Icons.assignment_late,
    Icons.person_pin,
    Icons.flag,
    Icons.feedback,
    Icons.power_settings_new,
  ];

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshHeaderState> _connectorHeaderKey =
      new GlobalKey<RefreshHeaderState>();

  List<String> listNames = [
    "Bài viết đang chờ",
    "Thành viên",
    "Báo cáo",
    "Phản hồi",
    "Đăng xuất"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    (() async {
      if (await Helper().check()) {
        fetchAmountUnprovedPost(adminBloc);
        fetchAmountUnrepFeedbacks(adminBloc);
        fetchAmountReport(adminBloc);
        fetchAmountUserReport(adminBloc);
      } else {
        new Future.delayed(const Duration(seconds: 1), () {
          Toast.show("Vui lòng kiểm tra mạng!", context,
              gravity: Toast.CENTER, backgroundColor: Colors.black87);
        });
      }
    })();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    adminBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProviderTree(
        blocProviders: [
          BlocProvider<AdminBloc>(
            bloc: adminBloc,
          )
        ],
        child: BlocBuilder(
          bloc: adminBloc,
          builder: (context, AdminState state) {
            return MaterialApp(
                builder: (context, child) {
                  return ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: child,
                  );
                },
                title: 'Flutter Demo',
                theme: ThemeData(
                  fontFamily: 'Montserrat',
                  canvasColor: Colors.transparent,
                ),
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      brightness: Brightness.light,
                      elevation: 0.5,
                      centerTitle: true,
                      title: Container(
                        child: new Text(
                          'Công cụ quản trị',
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
                    body: EasyRefresh(
                      key: _easyRefreshKey,
                      refreshHeader: ConnectorHeader(
                          key: _connectorHeaderKey,
                          header: DeliveryHeader(key: _headerKey)),
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate(<Widget>[
                              DeliveryHeader(
                                key: _headerKey,
                                backgroundColor: colorBackground,
                              )
                            ]),
                          ),
                          SliverList(
                              delegate: SliverChildListDelegate(<Widget>[
                            StaggeredGridView.countBuilder(
                                padding: EdgeInsets.only(top: 0),
                                crossAxisCount: 3,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    GestureDetector(
                                      onTap: () async {
                                        if (!onTap) {
                                          setState(() {
                                            onTap = true;
                                          });
                                          switch (index) {
                                            case 0:
                                              {
                                                setState(() {
                                                  onTap = false;
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdminPostManage(),
                                                  ),
                                                );
                                              }
                                              break;

                                            case 1:
                                              {
                                                setState(() {
                                                  onTap = false;
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserManagePage(),
                                                  ),
                                                );
                                              }
                                              break;

                                            case 2:
                                              {
                                                setState(() {
                                                  onTap = false;
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdminReportManage(),
                                                  ),
                                                );
                                              }
                                              break;

                                            case 3:
                                              {
                                                setState(() {
                                                  onTap = false;
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FeedbackAdmin(),
                                                  ),
                                                );
                                              }
                                              break;

                                            case 4:
                                              {
                                                setState(() {
                                                  onTap = false;
                                                });
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.remove('token');
                                                BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
                                                userBloc.logout();
                                              }
                                              break;

                                            default:
                                              {}
                                              break;
                                          }
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 8,
                                            right: index == 2 ? 8 : 0,
                                            top: 30),
                                        color: Colors.white,
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                      color: colorBackground,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  100))),
                                                  child: Icon(
                                                    listIcons[index],
                                                    size: 30,
                                                  ),
                                                ),
                                                (index == 0 &&
                                                            state.amountUnprovedPost !=
                                                                0) ||
                                                        (index == 1 &&
                                                            state.amountUserReports !=
                                                                0) ||
                                                        (index == 2 &&
                                                            state.amountReports !=
                                                                0) ||
                                                        (index == 3 &&
                                                            state.amountFeedbacks !=
                                                                0)
                                                    ? Positioned(
                                                        right: 0,
                                                        top: 0,
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    1),
                                                            decoration:
                                                                new BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            constraints:
                                                                BoxConstraints(
                                                              minWidth: 18,
                                                              minHeight: 18,
                                                            ),
                                                            child: Center(
                                                              child: new Text(
                                                                index == 0
                                                                    ? state.amountUnprovedPost >
                                                                            20
                                                                        ? " 20+ "
                                                                        : state
                                                                            .amountUnprovedPost
                                                                            .toString()
                                                                    : index == 1
                                                                        ? state.amountUserReports >
                                                                                20
                                                                            ? " 20+ "
                                                                            : state.amountUserReports
                                                                                .toString()
                                                                        : index ==
                                                                                2
                                                                            ? state.amountReports > 20
                                                                                ? " 20+ "
                                                                                : state.amountReports.toString()
                                                                            : state.amountFeedbacks > 20 ? " 20+ " : state.amountFeedbacks.toString(),
                                                                style:
                                                                    new TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 9,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            )))
                                                    : Positioned(
                                                        right: 0,
                                                        top: 0,
                                                        child: Container())
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                listNames[index],
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Ralway"),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                staggeredTileBuilder: (int index) =>
                                    new StaggeredTile.fit(1))
                          ])),
                        ],
                      ),
                      onRefresh: () async {
                        if (await Helper().check()) {
                          await fetchAmountUnprovedPost(adminBloc);
                          await fetchAmountUnrepFeedbacks(adminBloc);
                          await fetchAmountReport(adminBloc);
                          await fetchAmountUserReport(adminBloc);
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
        ));
  }
}
