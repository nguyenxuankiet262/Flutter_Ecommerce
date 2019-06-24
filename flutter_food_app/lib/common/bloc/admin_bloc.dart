import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/api/model/feedback.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/report.dart';
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

  void changeAmountPost(int amountPost){
    dispatch(ChangeAmountPost(amountPost));
  }

  void changeAmountReport(int amountReport){
    dispatch(ChangeAmountReport(amountReport));
  }

  void changeAmountFeedback(int amountFeedback){
    dispatch(ChangeAmountFeedback(amountFeedback));
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
        amountUnprovedPost: currentState.amountUnprovedPost,
        amountReports: currentState.amountReports,
        amountFeedbacks: event.amountFeedback,
      );
    }
  }
}
