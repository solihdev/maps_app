import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapping_app/data/api_service/api_service.dart';
import 'package:mapping_app/data/models/lat_long.dart';
import 'package:mapping_app/data/repositories/geocoding_repository.dart';
import 'package:mapping_app/ui/splash_screen/splash_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await GeoCodingRepository(apiService: ApiService())
        .getAddress(position as LocationModel, "");
    print("Location add");
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  await SharedPreferences.getInstance();
  Workmanager().registerOneOffTask("task-identifier", "simpleTask");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const soSplashScreen(),
    );
  }
}
