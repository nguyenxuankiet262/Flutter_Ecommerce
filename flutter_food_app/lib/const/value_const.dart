import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/model/child_menu.dart';
import 'package:flutter_food_app/model/menu.dart';

List<Menu> listMenu = [
  Menu('Tất cả', '', [
    ChildMenu('', 'Tất cả')
  ]),
  Menu('Thực phẩm tươi', 'assets/images/meat.jpg', [
    ChildMenu('', "Tất cả"),
    ChildMenu('assets/images/menu/vegetable.jpg', "Rau - Củ - Quả"),
    ChildMenu('assets/images/menu/eggs.jpg', "Trứng"),
    ChildMenu('assets/images/meat.jpg', "Thực phẩm tươi"),
  ]),
  Menu('Thực phẩm đông lạnh', 'assets/images/fish.jpg', [
    ChildMenu('', "Tất cả"),
    ChildMenu('assets/images/menu/sausage.jpg', "Đóng gói"),
    ChildMenu('assets/images/fish.jpg', "Tươi sống"),
  ]),
  Menu('Thực phẩm bổ dưỡng', 'assets/images/nutri.jpg', [
    ChildMenu('', "Tất cả"),
    ChildMenu('assets/images/menu/honey.jpg', "Mật ong"),
    ChildMenu('assets/images/nutri.jpg', "Thực phẩm bổ sung"),
  ]),
  Menu('Thực phẩm đóng gói', 'assets/images/package.jpg', [
    ChildMenu('', "Tất cả"),
    ChildMenu('assets/images/menu/rice.jpg', "Gạo"),
    ChildMenu('assets/images/package.jpg', "Đồ hộp"),
    ChildMenu('assets/images/menu/candy.jpg', "Bánh kẹo"),
    ChildMenu('assets/images/menu/noodle.jpg', "Thực phẩm ăn liền"),
  ]),
  Menu('Đồ ăn', 'assets/images/hamburger.jpg', [
    ChildMenu('', "Tất cả"),
    ChildMenu('assets/images/hamburger.jpg', "Đồ ăn"),
  ]),
  Menu('Nước uống', 'assets/images/drink.jpg', [
    ChildMenu('', "Tất cả"),
    ChildMenu('assets/images/menu/beer.jpg', "Nước có cồn"),
    ChildMenu('assets/images/menu/tea.jpg', "Trà"),
    ChildMenu('assets/images/menu/milktea.jpg', "Trà sữa"),
    ChildMenu('assets/images/menu/coca.jpg', "Nước ngọt"),
    ChildMenu('assets/images/menu/coffee.jpg', "Cà phê"),
    ChildMenu('assets/images/drink.jpg', "Khác"),
  ]),
  Menu('Khác', 'assets/images/other.jpg', [
    ChildMenu('', "Tất cả"),
    ChildMenu('assets/images/other.jpg', "Phụ gia"),
    ChildMenu('assets/images/menu/botchien.jpg', "Bột chiên"),
  ]),
];


const List<String> tabsRating = const <String>[
  '1',
  '2',
  '3',
  '4',
  '5',
];

const List<String> tabsOrder = const <String>[
  'Đơn hàng mới',
  'Giao dịch thành công',
  'Đơn hàng hủy',
];

const List<String> statusOptions = const <String>[
  'Đơn hàng mới',
  'Giao dịch thành công',
  'Đơn hàng hủy',
];

const List<String> tabsFeedback = const <String>[
  'Đã trả lời',
  'Chưa trả lời',
];

const List<String> listSort = const <String> [
  "Tin mới trước",
  "Tin cũ trước",
  "Yêu thích cao trước",
  "Yêu thích thấp trước",
  "Giá tăng dần",
  "Giá giảm dần",
];

const List<Icon> listIconSort = const <Icon> [
  Icon(
    FontAwesomeIcons.clock,
    size: 15,
  ),
  Icon(
    FontAwesomeIcons.history,
    size: 15,
  ),
  Icon(
    FontAwesomeIcons.thumbsUp,
    size: 15,
  ),
  Icon(
    FontAwesomeIcons.thumbsDown,
    size: 15,
  ),
  Icon(
    FontAwesomeIcons.sortNumericDown,
    size: 15,
  ),
  Icon(
    FontAwesomeIcons.sortNumericUp,
    size: 15,
  ),
];

const List<String> hotkeys = const <String> [
  "Chuối",
  "Bánh mì",
  "Táo",
  "Gạo tẻ",
  "Thịt cừu",
  "Tôm càng xanh"
];

const List<String> hotUsers = const <String> [
  "kiki_123",
  "meowmeow",
  "karik232",
  "erik",
  "ronaldo_cr7",
  "messi_10"
];