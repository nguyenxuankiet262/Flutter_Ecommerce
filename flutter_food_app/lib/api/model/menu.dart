class Menu {
  final String id;
  final String name;
  final String image;

  Menu({this.id, this.name,this.image});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}