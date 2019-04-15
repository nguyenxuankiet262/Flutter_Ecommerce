abstract class AddressEvent{}

class ChangeIndex extends AddressEvent{
  final int index;
  ChangeIndex(this.index);
}

class ChangeText extends AddressEvent{
  final String text;
  ChangeText(this.text);
}

class BackpressDetail extends AddressEvent{
  final Function backpressDetail;
  BackpressDetail(this.backpressDetail);
}

class BackpressChild extends AddressEvent{
  final Function backpressChild;
  BackpressChild(this.backpressChild);
}
