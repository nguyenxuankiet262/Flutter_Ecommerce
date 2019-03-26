import 'package:flutter_food_app/model/child_menu.dart';
import 'package:flutter_food_app/model/menu.dart';

List<Menu> listMenu = [
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

const List<String> tabsPost = const <String>[
  'Tất cả',
  'Đặt mua nhiều',
  'Yêu thích cao',
  'Yêu thích thấp',
  '5 sao',
  '4 sao',
  '3 sao',
  '2 sao',
  '1 sao',
];

const List<String> tabsFavorite = const <String>[
  'Tất cả',
  'Yêu thích cao',
  'Yêu thích thấp',
  '5 sao',
  '4 sao',
  '3 sao',
  '2 sao',
  '1 sao',
];
const List<String> tabsOrder = const <String>[
  'Tất cả',
  'Đơn hàng mới',
  'Giao dịch thành công',
  'Đơn hàng hủy',
];