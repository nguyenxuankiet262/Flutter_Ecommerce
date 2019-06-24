class InfoState {
  final String username;
  final String avatar;
  final String phone;
  final String address;
  final String name;
  final String coverphoto;
  final String intro;
  final String link;

  const InfoState({
    this.username,
    this.avatar,
    this.phone,
    this.address,
    this.name,
    this.coverphoto,
    this.intro,
    this.link
  });

  factory InfoState.initial() => InfoState(
    username: "",
    avatar: "",
    phone: "",
    address: "",
    name: "",
    coverphoto: "",
    intro: "",
    link: "",
  );
}
