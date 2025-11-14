import 'package:edufy_mobile/src/app.dart';
import 'package:flutter/material.dart';
import 'package:edufy_mobile/src/core/dependencies/ioc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo DI, repositories, Dio, v.v...
  await Ioc.initialize();

  runApp(const EdufyApp());
}
