import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_iot/injector/locator.dart';
import 'package:mobile_iot/pages/main_page.dart';
import 'package:mobile_iot/providers/node_provider.dart';
import 'package:mobile_iot/providers/page_provider.dart';
import 'package:mobile_iot/providers/sensors_provider.dart';
import 'package:mobile_iot/utils/logger.dart';
import 'package:provider/provider.dart';

const String _h = '[main]';
void main() async {
  Logger().setLogLevel(LogLevel.debugFinest);
  await dotenv.load(fileName: ".env");
  logSuccess(_h, ".env loaded");
  WidgetsFlutterBinding.ensureInitialized();
  // depedency injector
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NodeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SensorProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IoT',
        home: MainPage(),
      ),
    );
  }
}
