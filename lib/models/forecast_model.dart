class ForecastModel {
  ForecastModel({
    required this.temperature,
    required this.dateTime,
  });

  List<double> temperature;
  List<DateTime> dateTime;

  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
        temperature:
            List<double>.from(json["temperature"].map((x) => x.toDouble())),
        dateTime: List<DateTime>.from(
          json["dateTime"].map(
            (x) => DateTime.fromMillisecondsSinceEpoch(
              x * 1000,
              isUtc: true,
            ).toLocal(),
          ),
        ),
      );
}
