import 'package:flutter/material.dart';
import 'package:mobile_iot/providers/node_provider.dart';
import 'package:mobile_iot/providers/sensors_provider.dart';
import 'package:mobile_iot/widgets/weather_card.dart';
import 'package:mobile_iot/widgets/weather_header.dart';
import 'package:mobile_iot/widgets/weather_info.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _handleLoadData();
  }

  _handleLoadData() async {
    NodeProvider _nodeProvider =
        Provider.of<NodeProvider>(context, listen: false);
    SensorProvider _sensorProvider =
        Provider.of<SensorProvider>(context, listen: false);
    await _nodeProvider.getNode();
    await _sensorProvider.getResampled();
  }

  @override
  Widget build(BuildContext context) {
    NodeProvider _nodeProvider = Provider.of<NodeProvider>(context);
    SensorProvider _sensorProvider = Provider.of<SensorProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WeatherHeader(
                city: _nodeProvider.node?.city ?? "",
                temperature: _nodeProvider.node?.lastReport?.temperature ?? 0,
                lastReport: _nodeProvider.node?.lastReport?.createdAt
                        .toIso8601String() ??
                    "",
              ),
              const SizedBox(height: 20),
              WeatherInfo(
                humidity: _nodeProvider.node?.lastReport?.humidity ?? 0,
                heatIndex: _nodeProvider.node?.lastReport?.heatIndex ?? 0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0.0),
                height: 250.0,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 8, top: 0, bottom: 0, right: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: _sensorProvider.resampled?.temperature.length,
                  itemBuilder: (BuildContext context, int i) => WeatherCard(
                    temperature: _sensorProvider.resampled?.temperature[i] ?? 0,
                    humidity: _sensorProvider.resampled?.humidity[i] ?? 0,
                    heatIndex: _sensorProvider.resampled?.heatIndex[i] ?? 0,
                    dateTime: _sensorProvider.resampled?.dateTime[i] ??
                        DateTime.now(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
