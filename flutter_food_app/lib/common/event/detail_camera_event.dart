abstract class DetailCameraEvent{}

class ChangeImageList extends DetailCameraEvent{
  final List<String> imagePaths;
  ChangeImageList(this.imagePaths);
}

class ChangeTitle extends DetailCameraEvent{
  final String title;
  ChangeTitle(this.title);
}

class ChangeContent extends DetailCameraEvent{
  final String content;
  ChangeContent(this.content);
}

class ChangeIndexCategory extends DetailCameraEvent{
  final int indexCategory;
  final int indexChildCategory;
  ChangeIndexCategory(this.indexCategory, this.indexChildCategory);
}

class ChangePriceBefore extends DetailCameraEvent{
  final String priceBefore;
  ChangePriceBefore(this.priceBefore);
}

class ChangePriceAfter extends DetailCameraEvent{
  final String priceAfter;
  ChangePriceAfter(this.priceAfter);
}
