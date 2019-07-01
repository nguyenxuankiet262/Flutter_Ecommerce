import 'package:flutter_food_app/api/model/feedback.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/report.dart';
import 'package:flutter_food_app/api/model/report_user.dart';
import 'package:flutter_food_app/api/model/user.dart';

class AdminState {
  final List<Product> listUnprovedProducts;
  final List<Feedbacks> listFeedbacks;
  final List<Report> listReports;
  final List<User> listUser;
  final List<User> listReviewUsers;
  final List<User> listSearchUser;
  final List<ReportUser> listUserReport;
  final int amountUnprovedPost;
  final int amountFeedbacks;
  final int amountReports;
  final int amountUserReports;

  const AdminState({
    this.listUnprovedProducts,
    this.listFeedbacks,
    this.listReports,
    this.listUser,
    this.listReviewUsers,
    this.listSearchUser,
    this.listUserReport,
    this.amountUnprovedPost,
    this.amountFeedbacks,
    this.amountReports,
    this.amountUserReports,
  });

  factory AdminState.initial() => AdminState(
    listUnprovedProducts: null,
    listFeedbacks: null,
    listReports: null,
    listUser: null,
    listReviewUsers: null,
    listSearchUser: null,
    listUserReport: null,
    amountUnprovedPost: 0,
    amountFeedbacks: 0,
    amountReports: 0,
    amountUserReports: 0,
  );
}
