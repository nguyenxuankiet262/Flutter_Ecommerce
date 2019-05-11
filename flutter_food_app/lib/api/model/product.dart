class Product {
  final String id;
  final List<String> images;
  final bool proved;
  final bool status;
  final String name;
  final String idType;
  final String description;
  final String initPrice;
  final String currentPrice;
  final String idUser;
  final DateTime date;


  Product({this.id, this.images, this.proved, this.status, this.name,
      this.idType, this.description, this.initPrice, this.currentPrice, this.idUser, this.date});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      proved: json['proved'],
      status: json['status'],
      name: json['name'],
      idType: json['idtype'],
      description: json['description'],
      initPrice: json['initprice'].toString(),
      currentPrice: json['currentprice'].toString(),
      idUser: json['iduser'],
      date: DateTime.parse(json["day"]),
      images: new List<String>.from(json["img"].map((x) => x)),
    );
  }
}