abstract class PostManageEvent{}

class ChangeCategory extends PostManageEvent{
  final int indexCategory;
  final int indexChildCategory;
  ChangeCategory(this.indexCategory, this.indexChildCategory);
}

class ChangeFilter extends PostManageEvent{
  final int filter;
  ChangeFilter(this.filter);
}
