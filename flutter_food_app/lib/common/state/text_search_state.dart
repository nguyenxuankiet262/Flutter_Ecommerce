class TextSearchState{
  final String searchInput;
  final int index;

  const TextSearchState({this.index, this.searchInput});

  factory TextSearchState.initial() => TextSearchState(index: 1, searchInput: "");
}