import 'package:flutter/material.dart';
import 'package:mobile_iot/injector/locator.dart';
import 'package:mobile_iot/models/node_model.dart';
import 'package:mobile_iot/models/node_pagination_model.dart';
import 'package:mobile_iot/services/node_service.dart';
import 'package:mobile_iot/utils/shared_preference.dart';

class NodeProvider with ChangeNotifier {
  final _prefsLocator = getIt.get<SharedPreferenceHelper>();
  final _nodeService = NodeService();

  List<NodeModel> _nodes = [];
  bool _paginationHasNext = true;
  NodeModel? _node;

  NodeModel? get node => (_node);
  List<NodeModel> get nodes => (_nodes);

  set currentNode(NodeModel node) {
    _prefsLocator.setNodeId(id: node.id);
    _node = node;
    notifyListeners();
  }

  Future<bool> getNodes({
    String? search,
    required int pageSize,
    required int page,
    required bool firstFetch,
  }) async {
    try {
      if (!_paginationHasNext && !firstFetch) {
        return false;
      }
      NodePaginationModel pagination = await _nodeService.getNodes(
        search: search,
        page: page,
        pageSize: pageSize,
      );
      if (firstFetch) {
        _nodes = pagination.items;
      } else {
        _nodes.addAll(pagination.items);
      }
      _paginationHasNext = pagination.count >= pageSize * (page + 1);

      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getNode() async {
    try {
      NodeModel node = await _nodeService.getNode(
        nodeId: _prefsLocator.getNodeId()!,
      );
      _node = node;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
