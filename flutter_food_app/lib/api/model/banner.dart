class Banners {
  String id;
  String idProduct;
  String img;
  int v;

  Banners({
    this.id,
    this.idProduct,
    this.img,
    this.v,
  });

  factory Banners.fromJson(Map<String, dynamic> json) => new Banners(
    id: json["_id"],
    idProduct: json["IDProduct"],
    img: json["img"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "IDProduct": idProduct,
    "img": img,
    "__v": v,
  };
}