class LocationState{
  final List<String> nameCities;
  final List<List<String>> nameProvinces;

  const LocationState({this.nameCities, this.nameProvinces});

  factory LocationState.initial() => LocationState(nameCities: [
  ],
  nameProvinces: [
  ]);
}