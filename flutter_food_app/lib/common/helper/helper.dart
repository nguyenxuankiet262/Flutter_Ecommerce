import 'package:intl/intl.dart';

final oCcy = NumberFormat("###,###,###", "vi");
class Helper{
  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} năm";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} tháng";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} tuần";
    if (diff.inDays > 0)
      return "${diff.inDays} ngày";
    if (diff.inHours > 0)
      return "${diff.inHours} giờ";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} phút";
    return "Vừa xong";
  }

  String onCalculatePercentDiscount(String _initPrice, String _currentPrice){
    double temp = ((double.parse(_initPrice) - double.parse(_currentPrice)) / double.parse(_initPrice)) * 100;
    String percent = temp.round().toString() + "%";
    return percent.toString();
  }

  String onFormatPrice(String price){
    return oCcy.format(double.parse(price)) + " ₫";
  }
}