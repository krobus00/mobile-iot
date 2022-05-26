import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_iot/providers/node_provider.dart';
import 'package:mobile_iot/widgets/node_card.dart';
import 'package:provider/provider.dart';

class NodePage extends StatefulWidget {
  const NodePage({Key? key}) : super(key: key);

  @override
  State<NodePage> createState() => _NodePageState();
}

class _NodePageState extends State<NodePage> {
  @override
  void initState() {
    super.initState();
    _handleLoadData();
  }

  _handleLoadData() async {
    NodeProvider _nodeProvider =
        Provider.of<NodeProvider>(context, listen: false);
    await _nodeProvider.getNodes();
  }

  @override
  Widget build(BuildContext context) {
    NodeProvider _nodeProvider = Provider.of<NodeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: _nodeProvider.nodes
              .map(
                (n) => NodeCard(
                  node: n,
                  selectedNode: _nodeProvider.node,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
