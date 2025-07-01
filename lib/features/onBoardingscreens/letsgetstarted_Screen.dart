import 'package:flutter/material.dart';
import 'package:movoprive/features/authentication/login/login_email.dart';
import 'package:movoprive/features/authentication/login/login_phonenum.dart';
import '../../Selection_Screen.dart';
import '../../base/constants/app_constants.dart';
import '../../base/constants/app_images.dart';
import '../../base/app_widget/gradient_btn.dart'; // Import the GradientButton

class LetsGetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF333333), // Dark purple at top
              Color(0xFF2D0A53), // Purple in middle
              Color(0xFF8B7500), // Gold/amber at bottom
            ],
            stops: [0.0, 0.3, 0.6],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Logo with text at the top
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppImages.logowithtext_img,
                  width: 300,
                ),
              ),

              // Main image positioned below logo
              Positioned(
                top: size.height * 0.30, // Adjust this value to move the image up or down
                left: 0,
                right: 0,
                height: size.height * 0.5, // Adjust this value to control image height
                child: Image.asset(
                  AppImages.let_get_Started_img,
                  fit: BoxFit.cover,
                ),
              ),

              // GradientButton at the bottom
              Positioned(
                bottom: 40, // Adjust this value to move button up or down
                left: 40,
                right: 40,
                child: GradientButton(
                  text: "LET'S GET STARTED",
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectionScreen()),

                    );
                    // Navigate to the next screen
                  },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}