import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile_iot/constants/endpoint.dart';
import 'package:mobile_iot/injector/locator.dart';
import 'package:mobile_iot/models/forecast_model.dart';
import 'package:mobile_iot/models/sensors_model.dart';
import 'package:mobile_iot/services/dio_service.dart';
import 'package:mobile_iot/utils/logger.dart';

const _h = "[SENSOR SERVICE]";

class SensorService {
  final _networkLocator = getIt.get<DioClient>();

  Future<ResampledModel> getResampled({required String nodeId}) async {
    try {
      var body = jsonEncode({
        'startDate': DateTime.now()
                .subtract(const Duration(days: 1))
                .millisecondsSinceEpoch ~/
            1000,
        'endDate': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      });
      final response = await _networkLocator.dio.post(
        "$resampledEndpoint/$nodeId",
        data: body,
      );

      var res = response.data['data'];
      ResampledModel data = ResampledModel.fromJson(res);
      return data;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var dioException = e as DioError;
        final result = dioException.response!;
        logError(_h, result.data.toString());
        throw Exception("Internal Server Error");
      }
      logError(_h, e.toString());
      throw Exception("Something wrong");
    }
  }

  Future<ForecastModel> getForecast({required String nodeId}) async {
    try {
      final response = await _networkLocator.dio.get(
        "$forecastEndpoint/$nodeId",
      );

      var res = response.data['data'];
      ForecastModel data = ForecastModel.fromJson(res);
      return data;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var dioException = e as DioError;
        final result = dioException.response!;
        logError(_h, result.data.toString());
        throw Exception("Internal Server Error");
      }
      logError(_h, e.toString());
      throw Exception("Something wrong");
    }
  }
}
