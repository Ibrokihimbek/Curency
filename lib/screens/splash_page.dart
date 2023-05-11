import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valyuta_kursi/screens/home_page.dart';
import 'package:valyuta_kursi/screens/utils/images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
            width:double.infinity.w,
            height: double.infinity.h,
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
