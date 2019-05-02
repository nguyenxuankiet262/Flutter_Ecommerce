import 'dart:async';
import 'dart:convert';
import 'package:flutter_food_app/api/model/menu.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:http/http.dart' as http;

final String url = 'http://192.168.100.184/foodapp/';

fetchPhotos(ApiBloc apiBloc) async {
  final response = await http.get(url + 'getmenu.php');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Menu> temp = parsed.map<Menu>((json) => Menu.fromJson(json)).toList();
    print(temp[0].image);
    apiBloc.changeMenu(temp);
  }
}

Future<Menu> getPhotoById() async {
  final response = await http.post(url + 'getmenubyid.php', body: {'id': '2'});
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Menu> temp = parsed.map<Menu>((json) => Menu.fromJson(json)).toList();
  }
}
