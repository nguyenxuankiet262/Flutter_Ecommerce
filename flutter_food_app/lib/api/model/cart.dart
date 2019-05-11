class Cart {
  List<Items> items;
  String id;
  String iduser;

  Cart({
    this.items,
    this.id,
    this.iduser,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: new List<Items>.from(json["product"].map((x) => Items.fromJson(x))),
      id: json["_id"],
      iduser: json["iduser"],
    );
  }
}

class Items {
  String id;
  int qty;

  Items({
    this.id,
    this.qty,
  });

  factory Items.fromJson(Map<String, dynamic> json) => new Items(
    id: json["id"],
    qty: json["qty"],
  );
}
