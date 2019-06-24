import 'package:flutter_food_app/api/model/feedback.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/report.dart';

class AdminState {
  final List<Product> listUnprovedProducts;
  final List<Feedbacks> listFeedbacks;
  final List<Report> listReports;
  final int amountUnprovedPost;
  final int amountFeedbacks;
  final int amountReports;

  const AdminState({
    this.listUnprovedProducts,
    this.listFeedbacks,
    this.listReports,
    this.amountUnprovedPost,
    this.amountFeedbacks,
    this.amountReports,
  });

  factory AdminState.initial() => AdminState(
    listUnprovedProducts: null,
    listFeedbacks: null,
    listReports: null,
    amountUnprovedPost: 0,
    amountFeedbacks: 0,
    amountReports: 0,
  );
}
