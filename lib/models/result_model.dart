class Distance {
  ///{
  //     "statusCode": 200,
  //     "body": {
  //         "distance": {
  //             "meters": 1111760.0127584368,
  //             "kilometers": 1111.760012758437,
  //             "miles": 690.817361625534
  //         }
  //     }
  // }

  double meters;
  double kilometers;
  double miles;

  Distance({
    required this.meters,
    required this.kilometers,
    required this.miles,
  });

  factory Distance.fromMap(Map<String, dynamic> json) {
    final map = json['body']['distance'];
    return Distance(
      meters: map['meters'] as double,
      kilometers: map['kilometers'] as double,
      miles: map['miles'] as double,
    );
  }
}
