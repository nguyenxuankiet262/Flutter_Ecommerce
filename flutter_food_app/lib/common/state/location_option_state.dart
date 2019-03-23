class LocationOptionState{
  final int indexCity;
  final int indexProvince;

  const LocationOptionState({this.indexCity, this.indexProvince});

  factory LocationOptionState.initial() => LocationOptionState(
    indexCity: 5,
    indexProvince: 0
  );
}