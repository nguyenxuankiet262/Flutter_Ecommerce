abstract class TextSearchEvent{}

class SearchInput extends TextSearchEvent{
  final String searchInput;
  final int index;

  SearchInput(this.index, this.searchInput);
}

