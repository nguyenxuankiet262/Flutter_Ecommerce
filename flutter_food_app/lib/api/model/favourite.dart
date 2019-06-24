class Favourite{
  String id;
  String idproduct;

  Favourite({
    this.id,
    this.idproduct,
  });

  factory Favourite.fromJson(Map<String, dynamic> json) => new Favourite(
    id: json["_id"],
    idproduct: json["idproduct"],
  );
}