import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  final double humidity;
  final double heatIndex;
  const WeatherInfo({Key? key, required this.humidity, required this.heatIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Humidity",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "$humidity%",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Heat Index",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                heatIndex.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
