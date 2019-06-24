abstract class InfoEvent{}

class ChangeInfo extends InfoEvent{
  final String username;
  final String phone;
  final String address;
  final String name;
  final String intro;
  final String link;
  ChangeInfo(this.username, this.phone, this.address, this.name, this.intro, this.link);
}

class ChangeAvatar extends InfoEvent{
  final String avatar;
  ChangeAvatar(this.avatar);
}

class ChangeCover extends InfoEvent{
  final String coverphoto;
  ChangeCover(this.coverphoto);
}
