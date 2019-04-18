import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/detail_camera_event.dart';
import 'package:flutter_food_app/common/state/detail_camera.dart';

class DetailCameraBloc extends Bloc<DetailCameraEvent, DetailCameraState> {
  void changeImageList(List<String> imagePaths) {
    dispatch(ChangeImageList(imagePaths));
  }

  void changeTitle(String title) {
    dispatch(ChangeTitle(title));
  }

  void changeContent(String content) {
    dispatch(ChangeContent(content));
  }

  void changeIndexCategory(int category, int childCategory) {
    dispatch(ChangeIndexCategory(category, childCategory));
  }

  void changePriceBefore(String price) {
    dispatch(ChangePriceBefore(price));
  }

  void changePriceAfter(String price) {
    dispatch(ChangePriceAfter(price));
  }
  @override
  // TODO: implement initialState
  DetailCameraState get initialState => DetailCameraState.initial();

  @override
  Stream<DetailCameraState> mapEventToState(DetailCameraState currentState, DetailCameraEvent event) async* {
    if(event is ChangeImageList){
      yield DetailCameraState(
        imagePaths: event.imagePaths,
        title: currentState.title,
        content: currentState.content,
        indexCategory: currentState.indexCategory,
        indexChildCategory: currentState.indexChildCategory,
        priceBefore: currentState.priceBefore,
        priceAfter: currentState.priceAfter
      );
    }
    if(event is ChangeTitle){
      yield DetailCameraState(
          imagePaths: currentState.imagePaths,
          title: event.title,
          content: currentState.content,
          indexCategory: currentState.indexCategory,
          indexChildCategory: currentState.indexChildCategory,
          priceBefore: currentState.priceBefore,
          priceAfter: currentState.priceAfter
      );
    }
    if(event is ChangeContent){
      yield DetailCameraState(
          imagePaths: currentState.imagePaths,
          title: currentState.title,
          content: event.content,
          indexCategory: currentState.indexCategory,
          indexChildCategory: currentState.indexChildCategory,
          priceBefore: currentState.priceBefore,
          priceAfter: currentState.priceAfter
      );
    }
    if(event is ChangeIndexCategory){
      yield DetailCameraState(
          imagePaths: currentState.imagePaths,
          title: currentState.title,
          content: currentState.content,
          indexCategory: event.indexCategory,
          indexChildCategory: event.indexChildCategory,
          priceBefore: currentState.priceBefore,
          priceAfter: currentState.priceAfter
      );
    }
    if(event is ChangePriceBefore){
      yield DetailCameraState(
          imagePaths: currentState.imagePaths,
          title: currentState.title,
          content: currentState.content,
          indexCategory: currentState.indexCategory,
          indexChildCategory: currentState.indexChildCategory,
          priceBefore: event.priceBefore,
          priceAfter: currentState.priceAfter
      );
    }
    if(event is ChangePriceAfter){
      yield DetailCameraState(
          imagePaths: currentState.imagePaths,
          title: currentState.title,
          content: currentState.content,
          indexCategory: currentState.indexCategory,
          indexChildCategory: currentState.indexChildCategory,
          priceBefore: currentState.priceBefore,
          priceAfter: event.priceAfter
      );
    }
  }

}