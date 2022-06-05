import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String nodeId = "nodeId";
  final SharedPreferences prefs;

  SharedPreferenceHelper({required this.prefs});

  Future<void> setNodeId({required String id}) async {
    await prefs.setString(nodeId, id);
  }

  Future<void> removeNodeId() async {
    await prefs.remove(nodeId);
  }

  String? getNodeId() {
    final id = prefs.getString(nodeId);
    return id;
  }
}
