class LocationModel {
  int? id;
  double longitude;
  double lattitude;
  String dateTime;

  LocationModel({
    required this.longitude,
    required this.lattitude,
    required this.dateTime,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      longitude: json["longitude"] ?? 0,
      lattitude: json["lattitude"] ?? 0,
      dateTime: json["dateTime"] ?? "",
    );
  }

  toJson() {
    return {
      "longitude": longitude,
      "lattitude": lattitude,
      "dateTime": dateTime,
    };
  }

  LocationModel copyWith(
          {int? id, double? longitude, double? lattitude, String? dateTime}) =>
      LocationModel(
        longitude: longitude ?? this.longitude,
        lattitude: lattitude ?? this.lattitude,
        dateTime: dateTime ?? this.dateTime,
      );
}
