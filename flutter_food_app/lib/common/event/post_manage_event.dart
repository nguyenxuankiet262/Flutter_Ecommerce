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

class ChangeTempCategory extends PostManageEvent{
  final int tempCategory;
  final int tempChildCategory;
  ChangeTempCategory(this.tempCategory, this.tempChildCategory);
}

class ChangeTempFilter extends PostManageEvent{
  final int tempFilter;
  ChangeTempFilter(this.tempFilter);
}
