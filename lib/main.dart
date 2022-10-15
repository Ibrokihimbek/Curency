import 'package:flutter/material.dart';
import 'package:valyuta_kursi/screens/home_page.dart';
import 'package:valyuta_kursi/screens/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valyuta Kursi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash_Page()
    );
  }
}

