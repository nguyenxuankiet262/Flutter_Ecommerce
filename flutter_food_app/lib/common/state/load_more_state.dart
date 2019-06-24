class LoadMoreState {
  final int begin;
  final int end;

  const LoadMoreState({
    this.begin,
    this.end,
  });

  factory LoadMoreState.initial() => LoadMoreState(
        begin: 1,
        end: 10,
      );
}
