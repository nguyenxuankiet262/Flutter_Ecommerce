class FollowNotice {
  String id;
  String idProduct;
  DateTime day;
  bool seen;
  String avatar;
  String iduser;
  List<String> img;
  String name;

  FollowNotice({
    this.id,
    this.idProduct,
    this.day,
    this.seen,
    this.avatar,
    this.iduser,
    this.img,
    this.name,
  });

  factory FollowNotice.fromJson(Map<String, dynamic> json) => new FollowNotice(
    id: json["_id"],
    idProduct: json["id_product"],
    day: DateTime.parse(json["day"]),
    seen: json["seen"],
    avatar: json["avatar"],
    iduser: json["iduser"],
    img: new List<String>.from(json["img"].map((x) => x)),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "id_product": idProduct,
    "day": day.toIso8601String(),
    "seen": seen,
    "avatar": avatar,
    "iduser": iduser,
    "img": new List<dynamic>.from(img.map((x) => x)),
    "name": name,
  };
}
