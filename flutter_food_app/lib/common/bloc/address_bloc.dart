import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/address_event.dart';
import 'package:flutter_food_app/common/state/address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  void changeIndex(int index) {
    dispatch(ChangeIndex(index));
  }

  void changeText(String text) {
    dispatch(ChangeText(text));
  }

  void backpressDetail(Function backpressDetail) {
    dispatch(BackpressDetail(backpressDetail));
  }

  void backpressChild(Function backpressChild) {
    dispatch(BackpressChild(backpressChild));
  }

  @override
  // TODO: implement initialState
  AddressState get initialState => AddressState.initial();

  @override
  Stream<AddressState> mapEventToState(AddressState currentState,
      AddressEvent event) async* {
    // TODO: implement mapEventToState
    if(event is ChangeIndex){
      yield AddressState(
        index: event.index,
        address: currentState.address,
        backpressDetail: currentState.backpressDetail,
        backpressChild: currentState.backpressChild,
      );
    }
    if(event is ChangeText){
      yield AddressState(
        index: currentState.index,
        address: event.text,
        backpressDetail: currentState.backpressDetail,
        backpressChild: currentState.backpressChild,
      );
    }
    if(event is BackpressDetail){
      yield AddressState(
        index: currentState.index,
        address: currentState.address,
        backpressDetail: event.backpressDetail,
        backpressChild: currentState.backpressChild,
      );
    }
    if(event is BackpressChild){
      yield AddressState(
        index: currentState.index,
        address: currentState.address,
        backpressDetail: currentState.backpressDetail,
        backpressChild: event.backpressChild,
      );
    }
  }
}