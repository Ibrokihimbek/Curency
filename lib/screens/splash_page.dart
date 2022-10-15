import 'package:flutter/material.dart';
import 'package:valyuta_kursi/screens/home_page.dart';
import 'package:valyuta_kursi/screens/utils/images.dart';

class Splash_Page extends StatefulWidget {
  const Splash_Page({super.key});

  @override
  State<Splash_Page> createState() => _Splash_PageState();
}

class _Splash_PageState extends State<Splash_Page> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home_Page(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width:double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(MyImages.gif_curensy)),
            ),
            // color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
