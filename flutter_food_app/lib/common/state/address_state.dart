class AddressState {
  final int index;
  final String address;
  final Function backpressDetail;
  final Function backpressChild;

  const AddressState(
      {this.index, this.address, this.backpressDetail, this.backpressChild});

  factory AddressState.initial() => AddressState(
      index: 0, address: "", backpressDetail: () {}, backpressChild: () {});
}
