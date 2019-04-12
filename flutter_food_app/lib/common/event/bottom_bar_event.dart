abstract class BottomBarEvent{}

class ChangeVisibleFlag extends BottomBarEvent{
  final bool isVisible;
  ChangeVisibleFlag(this.isVisible);
}
