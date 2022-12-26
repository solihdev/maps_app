import 'package:flutter/material.dart';
import 'package:mapping_app/ui/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mapping App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
