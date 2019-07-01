import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/api/model/feedback.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/report.dart';
import 'package:flutter_food_app/api/model/report_user.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/event/admin_event.dart';
import 'package:flutter_food_app/common/state/admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {

  void changeUnprovedList(List<Product> listProducts) {
    dispatch(ChangeListUnprovedProducts(listProducts));
  }

  void changeFeedbackList(List<Feedbacks> listFeedbacks) {
    dispatch(ChangeFeedbacks(listFeedbacks));
  }

  void changeReportList(List<Report> listReports) {
    dispatch(ChangeReports(listReports));
  }

  void changeUserList(List<User> listUsers) {
    dispatch(ChangeListUser(listUsers));
  }

  void changeReviewUserList(List<User> listUsers) {
    dispatch(ChangeListReviewUser(listUsers));
  }

  void changeListSearchUser(List<User> listUsers) {
    dispatch(ChangeListSearchUser(listUsers));
  }

  void changeUserReportList(List<ReportUser> listUserReports) {
    dispatch(ChangeListUserReports(listUserReports));
  }

  void changeAmountPost(int amountPost){
    dispatch(ChangeAmountPost(amountPost));
  }

  void changeAmountReport(int amountReport){
    dispatch(ChangeAmountReport(amountReport));
  }

  void changeAmountFeedback(int amountFeedback){
    dispatch(ChangeAmountFeedback(amountFeedback));
  }

  void changeAmountUserReports(int amountUserReports){
    dispatch(ChangeAmountUserReports(amountUserReports));
  }


  @override
  // TODO: implement initialState
  AdminState get initialState => AdminState.initial();

  @override
  Stream<AdminState> mapEventToState(
      AdminState currentState, AdminEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ChangeListUnprovedProducts) {
      yield AdminState(
        listUnprovedProducts: event.listProducts,
        listFeedbacks: currentState.listFeedbacks,
        listReports: currentState.listReports,
        listUser: currentState.listUser,
        listReviewUsers: currentState.listReviewUsers,
        listSearchUser: currentState.listSearchUser,
        listUserReport: currentState.listUserReport,
        amountUserReports: currentState.amountUserReports,
        amountUnprovedPost: currentState.amountUnprovedPost,
        amountReports: currentState.amountReports,
        amountFeedbacks: currentState.amountFeedbacks,
      );
    }
    if (event is ChangeFeedbacks) {
      yield AdminState(
        listUnprovedProducts: currentState.listUnprovedProducts,
        listFeedbacks: event.listFeedbacks,
        listReports: currentState.listReports,
        listUser: currentState.listUser,
        listReviewUsers: currentState.listReviewUsers,
        listSearchUser: currentState.listSearchUser,
        listUserReport: currentState.listUserReport,
        amountUserReports: currentState.amountUserReports,
        amountUnprovedPost: currentState.amountUnprovedPost,
        amountReports: currentState.amountReports,
        amountFeedbacks: currentState.amountFeedbacks,
      );
    }
    if (event is ChangeReports) {
      yield AdminState(
        listUnprovedProducts: currentState.listUnprovedProducts,
        listFeedbacks: currentState.listFeedbacks,
        listReports: event.listReports,
        listUser: currentState.listUser,
        listReviewUsers: currentState.listReviewUsers,
        listSearchUser: currentState.listSearchUser,
        listUserReport: currentState.listUserReport,
        amountUserReports: currentState.amountUserReports,
        amountUnprovedPost: currentState.amountUnprovedPost,
        amountReports: currentState.amountReports,
        amountFeedbacks: currentState.amountFeedbacks,
      );
    }
    if (event is ChangeListUser) {
      yield AdminState(
        listUnprovedProducts: currentState.listUnprovedProducts,
        listFeedbacks: currentState.listFeedbacks,
        listReports: currentState.listReports,
        listUser: event.listUsers,
        listReviewUsers: currentState.listReviewUsers,
        listSearchUser: currentState.listSearchUser,
        listUserReport: currentState.listUserReport,
        amountUserReports: currentState.amountUserReports,
        amountUnprovedPost: currentState.amountUnprovedPost,
        amountReports: currentState.amountReports,
        amountFeedbacks: currentState.amountFeedbacks,
      );
    }
    if (event is ChangeListUserReports) {
      yield AdminState(
        listUnprovedProducts: currentState.listUnprovedProducts,
        listFeedbacks: currentState.listFeedbacks,
        listReports: currentState.listReports,
        listUser: currentState.listUser,
        listReviewUsers: currentState.listReviewUsers,
        listSearchUser: currentState.listSearchUser,
        listUserReport: event.listUserReports,
        amountUserReports: currentState.amountUserReports,
        amountUnprovedPost: currentState.amountUnprovedPost,
        amountReports: currentState.amountReports,
        amountFeedbacks: currentState.amountFeedbacks,
      );
    }
    if (event is ChangeAmountPost) {
      yield AdminState(
        listUnprovedProducts: currentState.listUnprovedProducts,
        listFeedbacks: currentState.listFeedbacks,
        listReports: currentState.listReports,
        listUser: currentState.listUser,
        listReviewUsers: currentState.listReviewUsers,
        listSearchUser: currentState.listSearchUser,
        listUserReport: currentState.listUserReport,
        amountUserReports: currentState.amountUserReports,
        amountUnprovedPost: event.amountPost,
        amountReports: currentState.amountReports,
        amountFeedbacks: currentState.amountFeedbacks,
      );
    }
    if (event is ChangeAmountReport) {
      yield AdminState(
        listUnprovedProducts: currentState.listUnprovedProducts,
        listFeedbacks: currentState.listFeedbacks,
        listReports: currentState.listReports,
        listUser: currentState.listUser,
        listReviewUsers: currentState.listReviewUsers,
        listSearchUser: currentState.listSearchUser,
        listUserReport: currentState.listUserReport,
        amountUserReports: currentState.amountUserReports,
        amountUnprovedPost: currentState.amountUnprovedPost,
        amountReports: event.amountReport,
        amountFeedbacks: currentState.amountFeedbacks,
      );
    }
    if (event is ChangeAmountFeedback) {
      yield AdminState(
        listUnprovedProducts: currentState.listUnprovedProducts,
        listFeedbacks: currentState.listFeedbacks,
        listReports: currentState.listReports,
        listUser: currentState.listUser,
        listReviewUsers: currentState.listReviewUsers,
        listSearchUser: currentState.listSearchUser,
        listUserReport: currentState.listUserReport,
        amountUserReports: currentState.amountUserReports,
        amountUnprovedPost: currentState.amountUnprovedPost,
        amountReports: currentState.amountReports,
        amountFeedbacks: event.amountFeedback,
      );
    }
    if (event is ChangeAmountUserReports) {
      yield AdminState(
        listUnprovedProducts: currentState.listUnprovedProducts,
        listFeedbacks: currentState.listFeedbacks,
        listReports: currentState.listReports,
        listUser: currentState.listUser,
        listReviewUsers: currentState.listReviewUsers,
        listSearchUser: currentState.listSearchUser,
        listUserReport: currentState.listUserReport,
        amountUserReports: event.amountUserReports,
        amountUnprovedPost: currentState.amountUnprovedPost,
        amountReports: currentState.amountReports,
        amountFeedbacks: currentState.amountFeedbacks,
      );
    }
    if (event is ChangeListSearchUser) {
      yield AdminState(
        listUnprovedProducts: currentState.listUnprovedProducts,
        listFeedbacks: currentState.listFeedbacks,
        listReports: currentState.listReports,
        listUser: currentState.listUser,
        listReviewUsers: currentState.listReviewUsers,
        listSearchUser: event.listSearchUsers,
        listUserReport: currentState.listUserReport,
        amountUserReports: currentState.amountUserReports,
        amountUnprovedPost: currentState.amountUnprovedPost,
        amountReports: currentState.amountReports,
        amountFeedbacks: currentState.amountFeedbacks,
      );
    }
    if (event is ChangeListReviewUser) {
      yield AdminState(
        listUnprovedProducts: currentState.listUnprovedProducts,
        listFeedbacks: currentState.listFeedbacks,
        listReports: currentState.listReports,
        listUser: currentState.listUser,
        listReviewUsers: event.listUsers,
        listSearchUser: currentState.listSearchUser,
        listUserReport: currentState.listUserReport,
        amountUserReports: currentState.amountUserReports,
        amountUnprovedPost: currentState.amountUnprovedPost,
        amountReports: currentState.amountReports,
        amountFeedbacks: currentState.amountFeedbacks,
      );
    }
  }
}
