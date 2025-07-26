import 'package:flutter/material.dart';
import 'package:your_store_app/app/app.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initCore();
  runApp(const MyApp());
}
