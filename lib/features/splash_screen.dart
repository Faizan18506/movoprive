import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movoprive/features/onBoardingscreens/onBoarding_1.dart';

import '../base/constants/app_images.dart';
import 'onBoardingscreens/letsgetstarted_Screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LetsGetStartedScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background SVG
          Positioned.fill(
            child: Image.asset(AppImages.splashImg_img, fit: BoxFit.cover),
          ),

          // Logo with text SVG
          Center(child: Image.asset(AppImages.logowithtext_img, width: 280)),

          // Bottom vehicle SVG
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Image.asset(AppImages.vechilelogo_img, width: 250),
            ),
          ),
        ],
      ),
    );
  }
}
