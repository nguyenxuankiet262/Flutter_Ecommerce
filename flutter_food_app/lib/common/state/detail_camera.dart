class DetailCameraState{
  final List<String> imagePaths;
  final String title;
  final String content;
  final int indexCategory;
  final int indexChildCategory;
  final String priceBefore;
  final String priceAfter;

  const DetailCameraState({this.imagePaths, this.title, this.content, this.indexCategory, this.indexChildCategory, this.priceBefore, this.priceAfter});

  factory DetailCameraState.initial() => DetailCameraState(
    imagePaths: [],
    title: "",
    content: "",
    indexCategory: 0,
    indexChildCategory: 0,
    priceBefore: "0",
    priceAfter: "0",
  );
}