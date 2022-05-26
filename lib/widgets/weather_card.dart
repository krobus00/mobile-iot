import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherCard extends StatelessWidget {
  final double temperature;
  final double humidity;
  final double heatIndex;
  final DateTime dateTime;

  const WeatherCard({
    Key? key,
    required this.temperature,
    required this.humidity,
    required this.heatIndex,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            )
          ]),
      child: Column(
        children: [
          Icon(
            WeatherIcons.na,
            size: 30,
          ),
          const Text(
            "Temp",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${temperature.toStringAsFixed(2)} \u00B0C",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          const Text(
            "Humidity",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${humidity.toStringAsFixed(2)} %",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Heat Index",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            heatIndex.toStringAsFixed(2),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          // const SizedBox(height: 10),
          // Text(
          //   DateFormat("yyyy-MM-dd").format(dateTime),
          //   style: const TextStyle(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 12,
          //     color: Colors.grey,
          //   ),
          // ),
          // const SizedBox(height: 5),
          // Text(
          //   DateFormat("kk:mm").format(dateTime),
          //   style: const TextStyle(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 12,
          //     color: Colors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }
}
