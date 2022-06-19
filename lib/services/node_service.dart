import 'package:dio/dio.dart';
import 'package:mobile_iot/constants/endpoint.dart';
import 'package:mobile_iot/injector/locator.dart';
import 'package:mobile_iot/models/node_model.dart';
import 'package:mobile_iot/models/node_pagination_model.dart';
import 'package:mobile_iot/services/dio_service.dart';
import 'package:mobile_iot/utils/logger.dart';
import 'package:mobile_iot/utils/shared_preference.dart';

const _h = "[NODE SERVICE]";

class NodeService {
  final _networkLocator = getIt.get<DioClient>();
  final _prefsLocator = getIt.get<SharedPreferenceHelper>();

  Future<NodeModel> getNode({required String nodeId}) async {
    try {
      String nodeId = _prefsLocator.getNodeId()!;
      final response = await _networkLocator.dio.get(
        "$nodesEndpoint/$nodeId",
      );
      var res = response.data['data'];
      NodeModel node = NodeModel.fromJson(res);
      return node;
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

  Future<NodePaginationModel> getNodes({
    String? search,
    required int pageSize,
    required int page,
  }) async {
    try {
      Map<String, dynamic> params = {
        'pageSize': pageSize,
        'page': page,
      };

      final response = await _networkLocator.dio.get(
        nodesEndpoint,
        queryParameters: params,
      );

      NodePaginationModel pagination =
          NodePaginationModel.fromJson(response.data);
      return pagination;
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
