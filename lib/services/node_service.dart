import 'package:dio/dio.dart';
import 'package:mobile_iot/constants/endpoint.dart';
import 'package:mobile_iot/injector/locator.dart';
import 'package:mobile_iot/models/node_model.dart';
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

  Future<List<NodeModel>> getNodes({
    String? search,
    // bool? top,
    // bool? random,
    // int? startPrice,
    // int? endPrice,
    // int? page = 1,
    // int? paginate = 10,
    // String? orderBy,
  }) async {
    try {
      // Map<String, dynamic> params = {
      //   'page': page ?? 1,
      //   'paginate': paginate ?? 10,
      // };
      // if (search != null) {
      //   params['search'] = search;
      // }
      // if (top != null) {
      //   params['top'] = "";
      // }
      // if (random != null) {
      //   params['random'] = paginate ?? 10;
      // }
      // if (startPrice != null) {
      //   params['start_price'] = startPrice;
      // }
      // if (endPrice != null) {
      //   params['endPrice'] = endPrice;
      // }

      final response = await _networkLocator.dio.get(
        nodesEndpoint,
        // queryParameters: params,
      );
      var res = response.data['items'];
      List<NodeModel> nodes = [];
      for (var node in res) {
        nodes.add(NodeModel.fromJson(node));
      }
      return nodes;
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
