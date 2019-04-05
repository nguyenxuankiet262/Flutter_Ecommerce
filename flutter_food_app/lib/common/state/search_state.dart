class SearchState{
  final bool isSearch;

  const SearchState({this.isSearch});

  factory SearchState.initial() => SearchState(isSearch: false);
}