import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/configuration.dart';
import 'modul_sales/sf_main.dart';
import 'module_mt/mt_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MainConfiguration configuration = MainConfiguration();
  if (!configuration.isSf()) {
    //await dimt.init();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    MainConfiguration configuration = MainConfiguration();
    if (configuration.isSf()) {
      return SFRootApp();
    } else {
      return MTRootApp();
    }
  }
}
