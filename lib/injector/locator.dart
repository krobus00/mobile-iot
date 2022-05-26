import 'package:get_it/get_it.dart';
import 'package:mobile_iot/services/dio_service.dart';
import 'package:mobile_iot/utils/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  final _prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferenceHelper>(
    SharedPreferenceHelper(prefs: _prefs),
  );
  getIt.registerSingleton<DioClient>(DioClient());
}
