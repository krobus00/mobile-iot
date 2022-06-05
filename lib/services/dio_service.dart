import 'package:dio/dio.dart';
import 'package:mobile_iot/constants/endpoint.dart';
import 'package:mobile_iot/utils/logger.dart';

const _h = "[DIO]";

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logDebug(
      _h,
      "REQUEST[${options.method}] => PATH: ${options.path}",
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logDebug(
      _h,
      "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}",
    );

    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    logDebug(
      _h,
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );

    return super.onError(err, handler);
  }
}

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseURL,
      headers: baseHeader,
      connectTimeout: 15000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());
  Dio get dio => _dio;
}
