abstract class LoadMoreEvent{}

class ChangeLoadMore extends LoadMoreEvent{
  final int begin;
  final int end;
  ChangeLoadMore(this.begin, this.end);
}