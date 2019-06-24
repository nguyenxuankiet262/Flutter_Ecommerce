class Badge {
  int sell;
  int buy;

  Badge({
    this.sell,
    this.buy,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => new Badge(
    sell: json["sell"],
    buy: json["buy"],
  );

  Map<String, dynamic> toJson() => {
    "sell": sell,
    "buy": buy,
  };
}
