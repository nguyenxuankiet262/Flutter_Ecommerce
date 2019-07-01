import 'package:flutter_food_app/api/model/feedback.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/report.dart';
import 'package:flutter_food_app/api/model/report_user.dart';
import 'package:flutter_food_app/api/model/user.dart';

abstract class AdminEvent{}

class ChangeListUnprovedProducts extends AdminEvent{
  final List<Product> listProducts;
  ChangeListUnprovedProducts(this.listProducts);
}

class ChangeFeedbacks extends AdminEvent{
  final List<Feedbacks> listFeedbacks;
  ChangeFeedbacks(this.listFeedbacks);
}

class ChangeReports extends AdminEvent{
  final List<Report> listReports;
  ChangeReports(this.listReports);
}

class ChangeListUser extends AdminEvent{
  final List<User> listUsers;
  ChangeListUser(this.listUsers);
}

class ChangeListReviewUser extends AdminEvent{
  final List<User> listUsers;
  ChangeListReviewUser(this.listUsers);
}

class ChangeListSearchUser extends AdminEvent{
  final List<User> listSearchUsers;
  ChangeListSearchUser(this.listSearchUsers);
}

class ChangeListUserReports extends AdminEvent{
  final List<ReportUser> listUserReports;
  ChangeListUserReports(this.listUserReports);
}


class ChangeAmountPost extends AdminEvent{
  final int amountPost;
  ChangeAmountPost(this.amountPost);
}

class ChangeAmountReport extends AdminEvent{
  final int amountReport;
  ChangeAmountReport(this.amountReport);
}

class ChangeAmountFeedback extends AdminEvent{
  final int amountFeedback;
  ChangeAmountFeedback(this.amountFeedback);
}

class ChangeAmountUserReports extends AdminEvent{
  final int amountUserReports;
  ChangeAmountUserReports(this.amountUserReports);
}