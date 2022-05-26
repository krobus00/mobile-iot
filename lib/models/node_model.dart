import 'package:mobile_iot/models/last_report.dart';

class NodeModel {
  NodeModel({
    required this.id,
    required this.city,
    required this.longitude,
    required this.latitude,
    required this.createdAt,
    required this.updatedAt,
    this.lastReport,
  });

  String id;
  String city;
  int longitude;
  int latitude;
  DateTime createdAt;
  DateTime updatedAt;
  LastReport? lastReport;

  factory NodeModel.fromJson(Map<String, dynamic> json) => NodeModel(
        id: json["id"],
        city: json["city"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(json["createdAt"] * 1000),
        updatedAt:
            DateTime.fromMillisecondsSinceEpoch(json["updatedAt"] * 1000),
        lastReport: json["lastReport"] != null
            ? LastReport.fromJson(json["lastReport"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "longitude": longitude,
        "latitude": latitude,
        "createdAt": createdAt.millisecondsSinceEpoch,
        "updatedAt": updatedAt.millisecondsSinceEpoch,
      };
}
