import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';

final oCcy = NumberFormat("###,###,###", "vi");
final fDay = new DateFormat('h:mm a dd-MM-yyyy');
class Helper{
  String formatDay(DateTime d){
    DateTime temp = new DateTime(d.year,d.month,d.day,d.hour + 7,d.minute,d.second,d.millisecond,d.microsecond);
    return fDay.format(temp);
  }

  String restTime(DateTime d) {
    Duration diff = DateTime(d.year,d.month,d.day,d.hour + 48,d.minute,d.second,d.millisecond,d.microsecond).difference(DateTime.now());
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

  DateTime plus7hourDateTime(DateTime d){
    DateTime temp = new DateTime(d.year,d.month,d.day,d.hour + 7,d.minute,d.second,d.millisecond,d.microsecond);
    return temp;
  }
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

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  String onFormatDBPrice(String price){
    return price.replaceAll(new RegExp(r'[^\w\s]+'),'');
  }
}