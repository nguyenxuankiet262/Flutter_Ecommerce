import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/admin_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/admin/member/report/report.dart';
import 'package:flutter_food_app/page/admin/member/review/review.dart';
import 'package:flutter_food_app/page/admin/member/user/user.dart';
import 'package:toast/toast.dart';

class UserManagePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => UserManagePageState();
}

class UserManagePageState extends State<UserManagePage>{
  AdminBloc adminBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminBloc = BlocProvider.of<AdminBloc>(context);
    (() async {
      if (await Helper().check()) {
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
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: adminBloc,
      builder: (context, AdminState state){
        return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                brightness: Brightness.light,
                elevation: 0.5,
                centerTitle: true,
                title: Container(
                  child: new Text(
                    'Thành viên',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      indicatorColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Text(
                            "NGƯỜI DÙNG",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Ralway",
                            ),
                          ),
                        ),
                        Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "BÁO CÁO",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Ralway",
                                  ),
                                ),
                                state.amountUserReports != 0
                                ? Container(
                                    margin: EdgeInsets.only(left: 8),
                                    height: 18,
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
                                        state.amountUserReports > 20
                                        ? " 20+ "
                                        : state.amountUserReports.toString(),
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
                                    ))
                                    : Container()
                              ],
                            )
                        ),
                        Tab(
                          child: Text(
                            "XEM XÉT",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Ralway",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                ),
              ),
              backgroundColor: Colors.white,
              body: TabBarView(
                children: [
                  UserPage(),
                  ReportUserPage(),
                  ReviewPage(),
                ],
              ),
            )
        );
      },
    );
  }
}