class LastReport {
  LastReport({
    required this.id,
    required this.nodeId,
    required this.humidity,
    required this.temperature,
    required this.heatIndex,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String nodeId;
  double humidity;
  double temperature;
  double heatIndex;
  DateTime createdAt;
  DateTime updatedAt;

  factory LastReport.fromJson(Map<String, dynamic> json) => LastReport(
        id: json["id"],
        nodeId: json["nodeId"],
        humidity: json["humidity"].toDouble(),
        temperature: json["temperature"].toDouble(),
        heatIndex: json["heatIndex"].toDouble(),
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(json["createdAt"] * 1000),
        updatedAt:
            DateTime.fromMillisecondsSinceEpoch(json["updatedAt"] * 1000),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nodeId": nodeId,
        "humidity": humidity,
        "temperature": temperature,
        "heatIndex": heatIndex,
        "createdAt": createdAt.millisecondsSinceEpoch,
        "updatedAt": updatedAt.millisecondsSinceEpoch,
      };
}
