abstract class LocationOptionEvent{}

class ChangeLocationOption extends LocationOptionEvent{
  final int indexCity;
  final int indexProvince;

  ChangeLocationOption(this.indexCity, this.indexProvince);
}
