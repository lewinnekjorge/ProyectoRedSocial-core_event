import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/app.dart';
import 'ui/pages/content_start.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<InicioWidget>(() => const InicioWidget(title: 'main'));

  runApp(const App());
}
