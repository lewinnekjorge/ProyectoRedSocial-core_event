import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import 'domain/models/location.dart';
import 'ui/app.dart';
import 'ui/pages/content_start.dart';
import 'package:core_event/domain/use_cases/location_management.dart';
import 'package:core_event/data/services/location.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<InicioWidget>(() => const InicioWidget(title: 'main'));
  Workmanager().initialize(
    updatePositionInBackground,
    isInDebugMode: true,
  );
  runApp(const App());
}

void updatePositionInBackground() async {
  final manager = LocationManager();
  final service = LocationService();
  Workmanager().executeTask((task, inputData) async {
    final position = await manager.getCurrentLocation();
    final details = await manager.retrieveUserDetails();
    var location = MyLocation(
        name: details['name']!,
        id: details['uid']!,
        lat: position.latitude,
        long: position.longitude);
    await service.fecthData(
      map: location.toJson,
    );
    log("updated location background"); //simpleTask will be emitted here.
    //print("updated location background"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}
