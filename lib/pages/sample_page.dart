import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:mobile_iot/constants/date.dart';
import 'package:mobile_iot/providers/node_provider.dart';
import 'package:mobile_iot/providers/sensors_provider.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
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
    await _sensorProvider.getForecast();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    NodeProvider _nodeProvider = Provider.of<NodeProvider>(context);
    SensorProvider _sensorProvider = Provider.of<SensorProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Today, ${now.day} ${months[now.month - 1]}",
                    style: const TextStyle(color: Colors.white54, fontSize: 24),
                  ),
                ],
              ),
              SizedBox(
                height: size.height - 380,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${_nodeProvider.node?.lastReport?.temperature ?? 0}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 96,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          "\u00B0C",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${_nodeProvider.node?.city}",
                      style: const TextStyle(color: Colors.white, fontSize: 36),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Last 24H",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "More detail",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _sensorProvider.resampled?.temperature.length,
                  itemBuilder: (BuildContext context, int i) => Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: BlurryContainer(
                      blur: 5,
                      width: 100,
                      height: 150,
                      elevation: 0,
                      color: Colors.black.withOpacity(0.2),
                      padding: const EdgeInsets.all(8),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('MMM d').format(
                                  _sensorProvider.resampled?.dateTime[i] ??
                                      DateTime.now()),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateFormat.Hm().format(
                                  _sensorProvider.resampled?.dateTime[i] ??
                                      DateTime.now()),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Icon(
                              WeatherIcons.thermometer,
                              size: 32,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "${_sensorProvider.resampled?.temperature[i].toStringAsFixed(1) ?? 0}\u00B0C",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Forecast Next 24H",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "More detail",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _sensorProvider.forecast?.temperature.length,
                  itemBuilder: (BuildContext context, int i) => Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: BlurryContainer(
                      blur: 5,
                      width: 100,
                      height: 150,
                      elevation: 0,
                      color: Colors.black.withOpacity(0.2),
                      padding: const EdgeInsets.all(8),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('MMM d').format(
                                  _sensorProvider.forecast?.dateTime[i] ??
                                      DateTime.now()),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateFormat.Hm().format(
                                  _sensorProvider.forecast?.dateTime[i] ??
                                      DateTime.now()),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Icon(
                              WeatherIcons.thermometer,
                              size: 32,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "${_sensorProvider.forecast?.temperature[i].toStringAsFixed(1) ?? 0}\u00B0C",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
