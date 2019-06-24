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

  Map<String, dynamic> toJson() => {
    "id": id,
    "qty": qty,
  };
}
