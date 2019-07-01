import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/admin_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:toast/toast.dart';

class ListReviewUser extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ListReviewUserState();
}

class ListReviewUserState extends State<ListReviewUser>{
  AdminBloc adminBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminBloc = BlocProvider.of(context);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: adminBloc,
      builder: (context, AdminState state){
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.listReviewUsers.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => Container(
              padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0, bottom: index == state.listReviewUsers.length - 1 ? 32 : 16),
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
                            MaterialPageRoute(builder: (context) => InfoAnotherPage(state.listReviewUsers[index].id)),
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
                                        state.listReviewUsers[index].avatar
                                    )
                                )
                            ),
                            child: state.listReviewUsers[index].status
                                ? state.listReviewUsers[index].isInReview.status
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
                                    MaterialPageRoute(builder: (context) => InfoAnotherPage(state.listReviewUsers[index].id)),
                                  );
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      state.listReviewUsers[index].name,
                                      style: TextStyle(
                                          fontFamily: "Ralway",
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      margin: EdgeInsets.only(left: 8.0),
                                      decoration: BoxDecoration(
                                          color: colorComment,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          border: Border.all(
                                              color: colorComment)),
                                      child: Center(
                                        child: Text(
                                          Helper().timeAgo(
                                              state.listReviewUsers[index].isInReview.day),
                                          style: TextStyle(
                                            color: colorInactive,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  state.listReviewUsers[index].username + " đã tham gia " + Helper().timeAgo(state.listReviewUsers[index].day),
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
                        if(!state.listReviewUsers[index].isInReview.status){
                          int check = await updateInReviewUser(adminBloc, state.listReviewUsers[index].id, true, 2, index);
                          if(check == 1){
                            Toast.show("Đã chuyển " + state.listReviewUsers[index].username + " sang Xem xét!", context);
                          }
                          else if(check == 0){
                            Toast.show("Không thành công!", context);
                          }
                          else{
                            Toast.show("Lỗi hệ thống!", context);
                          }
                        }
                        else{
                          int check = await updateInReviewUser(adminBloc, state.listReviewUsers[index].id, false, 2, index);
                          if(check == 1){
                            Toast.show("Đã tắt Xem xét thành công!", context);
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
                        child: Text(!state.listReviewUsers[index].isInReview.status
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
        );
      },
    );
  }
}