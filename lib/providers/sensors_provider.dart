import 'package:flutter/material.dart';
import 'package:mobile_iot/injector/locator.dart';
import 'package:mobile_iot/models/forecast_model.dart';
import 'package:mobile_iot/models/sensors_model.dart';
import 'package:mobile_iot/services/sensor_service.dart';
import 'package:mobile_iot/utils/shared_preference.dart';

class SensorProvider with ChangeNotifier {
  final _prefsLocator = getIt.get<SharedPreferenceHelper>();
  final _sensorService = SensorService();

  ResampledModel? _resampled;
  ResampledModel? get resampled => (_resampled);

  ForecastModel? _forecast;
  ForecastModel? get forecast => (_forecast);

  Future<bool> getResampled() async {
    try {
      String nodeId = _prefsLocator.getNodeId()!;
      ResampledModel data = await _sensorService.getResampled(nodeId: nodeId);
      _resampled = data;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getForecast() async {
    try {
      String nodeId = _prefsLocator.getNodeId()!;
      ForecastModel data = await _sensorService.getForecast(nodeId: nodeId);
      _forecast = data;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
