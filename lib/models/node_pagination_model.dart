import 'package:mobile_iot/models/node_model.dart';

class NodePaginationModel {
  NodePaginationModel({
    required this.currentPage,
    required this.itemsPerPage,
    required this.count,
    required this.totalPage,
    required this.items,
  });

  int currentPage;
  int itemsPerPage;
  int count;
  int totalPage;
  List<NodeModel> items;

  factory NodePaginationModel.fromJson(Map<String, dynamic> json) =>
      NodePaginationModel(
        currentPage: json["currentPage"],
        itemsPerPage: json["itemsPerPage"],
        count: json["count"],
        totalPage: json["totalPage"],
        items: List<NodeModel>.from(
          json["items"].map(
            (x) => NodeModel.fromJson(x),
          ),
        ),
      );
}
