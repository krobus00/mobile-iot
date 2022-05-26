import 'package:flutter/material.dart';
import 'package:mobile_iot/extension/string.dart';

class WeatherHeader extends StatelessWidget {
  final String city;
  final double temperature;
  final String lastReport;
  const WeatherHeader(
      {Key? key,
      required this.city,
      required this.temperature,
      required this.lastReport})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Current In ${city.toTitleCase()}",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            "$temperature \u00B0C",
            style: const TextStyle(
              fontSize: 46,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            lastReport,
            style: const TextStyle(fontSize: 12, color: Color(0xFF5A5A5A)),
          )
        ],
      ),
    );
  }
}
