class Coordinates {
  String startLatitude;
  String startLongitude;
  String endLatitude;
  String endLongitude;

  Coordinates({
    required this.startLatitude,
    required this.startLongitude,
    required this.endLatitude,
    required this.endLongitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'startLatitude': startLatitude,
      'startLongitude': startLongitude,
      'endLatitude': endLatitude,
      'endLongitude': endLongitude,
    };
  }

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(
      startLatitude: map['startLatitude'] as String,
      startLongitude: map['startLongitude'] as String,
      endLatitude: map['endLatitude'] as String,
      endLongitude: map['endLongitude'] as String,
    );
  }
}
