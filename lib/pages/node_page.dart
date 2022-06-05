import 'package:flutter/material.dart';
import 'package:mobile_iot/providers/node_provider.dart';
import 'package:mobile_iot/widgets/node_card.dart';
import 'package:provider/provider.dart';

class NodePage extends StatefulWidget {
  const NodePage({Key? key}) : super(key: key);

  @override
  State<NodePage> createState() => _NodePageState();
}

class _NodePageState extends State<NodePage> {
  late ScrollController _controller;
  final int _pageSize = 10;
  int _page = 1;
  bool _isLoading = false;

  void _loadMore() async {
    if (!_isLoading) {
      _page += 1;
      NodeProvider _nodeProvider =
          Provider.of<NodeProvider>(context, listen: false);
      setState(() {
        _isLoading = true;
      });
      bool hasNext = await _nodeProvider.getNodes(
        firstFetch: false,
        page: _page,
        pageSize: _pageSize,
      );
      if (!hasNext) {
        _page -= 1;
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _handleLoadData();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  _handleLoadData() async {
    NodeProvider _nodeProvider =
        Provider.of<NodeProvider>(context, listen: false);
    await _nodeProvider.getNodes(
        firstFetch: true, page: _page, pageSize: _pageSize);
  }

  @override
  Widget build(BuildContext context) {
    NodeProvider _nodeProvider = Provider.of<NodeProvider>(context);
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            controller: _controller,
            itemCount: _nodeProvider.nodes.length,
            itemBuilder: (_, index) => NodeCard(
              node: _nodeProvider.nodes[index],
              selectedNode: _nodeProvider.node,
            ),
          ),
        ),
        if (_isLoading == true)
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}
