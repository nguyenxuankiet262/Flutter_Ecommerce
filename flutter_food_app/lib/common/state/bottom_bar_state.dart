class BottomBarState{
  final bool isVisible;

  const BottomBarState({this.isVisible});

  factory BottomBarState.initial() => BottomBarState(isVisible: true);
}