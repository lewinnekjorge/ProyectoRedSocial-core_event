//import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import 'domain/models/location.dart';
import 'ui/app.dart';
import 'ui/pages/content_start.dart';
import 'package:core_event/domain/use_cases/location_management.dart';
import 'package:core_event/domain/use_cases/controllers/notifications.dart';
import 'package:core_event/domain/use_cases/notification_management.dart';
import 'package:core_event/data/services/location.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<InicioWidget>(() => const InicioWidget(title: 'main'));
  NotificationController notificationController =
      Get.put(NotificationController());
  await notificationController.initialize();

  notificationController.createChannel(
      id: '', name: '', description: 'Mi Ubicacion es ');

  await Workmanager().initialize(
    updatePositionInBackground,
    isInDebugMode: false,
  );
  await Workmanager().registerPeriodicTask(
    "2",
    "locationPeriodicTask",
  );
  runApp(const App());
}

void updatePositionInBackground() async {
  final manager = LocationManager();
  final _manager = NotificationManager();
  final service = LocationService();
  Workmanager().executeTask((task, inputData) async {
    await _manager.initialize();
    final position = await manager.getCurrentLocation();
    final details = await manager.retrieveUserDetails();
    var location = MyLocation(
        name: details['name']!,
        id: details['uid']!,
        lat: position.latitude,
        long: position.longitude);
    final _channel = _manager.createChannel(
        id: details['uid']!,
        name: details['name']!,
        description: 'Mi Ubicacion es ');
    _manager.showNotification(
        channel: _channel,
        title: details['name']!,
        body:
            'Tu Ubicaciòn es : Latitud ${position.latitude}, longitude: ${position.longitude}');
    await service.fecthData(
      map: location.toJson,
    );
    //log("updated location background"); //simpleTask will be emitted here.
    //print("updated location background"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}
