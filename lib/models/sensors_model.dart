class ResampledModel {
  ResampledModel({
    required this.humidity,
    required this.temperature,
    required this.heatIndex,
    required this.dateTime,
  });

  List<double> humidity;
  List<double> temperature;
  List<double> heatIndex;
  List<DateTime> dateTime;

  factory ResampledModel.fromJson(Map<String, dynamic> json) => ResampledModel(
        humidity: List<double>.from(json["humidity"].map((x) => x.toDouble())),
        temperature:
            List<double>.from(json["temperature"].map((x) => x.toDouble())),
        heatIndex:
            List<double>.from(json["heatIndex"].map((x) => x.toDouble())),
        dateTime: List<DateTime>.from(json["dateTime"]
            .map((x) => DateTime.fromMillisecondsSinceEpoch(x * 1000))),
      );
}
