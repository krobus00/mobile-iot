import 'package:flutter/material.dart';
import 'package:mobile_iot/models/node_model.dart';
import 'package:mobile_iot/providers/node_provider.dart';
import 'package:provider/provider.dart';

class NodeCard extends StatelessWidget {
  final NodeModel node;
  final NodeModel? selectedNode;
  const NodeCard({Key? key, required this.node, this.selectedNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NodeProvider _nodeProvider = Provider.of<NodeProvider>(context);
    return GestureDetector(
      onTap: () {
        _nodeProvider.currentNode = node;
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 5,
                  color:
                      selectedNode?.id == node.id ? Colors.green : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: Text(node.city),
              subtitle: Text(node.createdAt.toIso8601String()),
            ),
          ],
        ),
      ),
    );
  }
}
