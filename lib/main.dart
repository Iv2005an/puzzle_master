import 'package:flutter/material.dart';
import 'services/hive_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  final preferences = await SharedPreferences.getInstance();
  runApp(App(preferences));
}
