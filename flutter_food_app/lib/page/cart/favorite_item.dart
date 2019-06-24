import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:toast/toast.dart';

class FavoriteItem extends StatefulWidget {
  final int index;
  FavoriteItem(this.index);
  @override
  State<StatefulWidget> createState() => FavoriteItemState();
}

class FavoriteItemState extends State<FavoriteItem> {
  ApiBloc apiBloc;
  bool onTapFav = false;
  FunctionBloc functionBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state){
        return GestureDetector(
          onTap: () async {
            if(!onTapFav){
              if(state.cart.products[widget.index].isFavorite){
                setState(() {
                  onTapFav = true;
                });
                await isAddToFav(apiBloc, state.mainUser.id, state.cart.items[widget.index].id, false);
                setState(() {
                  onTapFav = false;
                });
              }
              else{
                setState(() {
                  onTapFav = true;
                });
                if(await checkStatusProduct(state.cart.items[widget.index].id) == 1) {
                  await isAddToFav(apiBloc, state.mainUser.id,
                      state.cart.items[widget.index].id, true);
                }
                else if(await checkStatusProduct(state.cart.items[widget.index].id) == 0){
                  Toast.show("Không thể thêm yêu thích sản phẩm bị xóa!", context, gravity: Toast.CENTER, duration: 2);
                }
                else{
                  Toast.show("Lỗi hệ thống!", context, gravity: Toast.CENTER);
                }
                setState(() {
                  onTapFav = false;
                });
              }
            }
          },
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10.0, bottom: 2.0),
                  child: Icon(
                    state.cart.products[widget.index].isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: state.cart.products[widget.index].isFavorite ? Colors.red : Colors.black,
                    size: 20,
                  ),
                ),
                Text(
                  'YÊU THÍCH',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
