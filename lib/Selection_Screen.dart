import 'package:flutter/material.dart';
import 'package:movoprive/features/Driver_side/D_authentication/D_screens/D_login_screen.dart';
import 'package:movoprive/features/authentication/login/login_email.dart';
import 'package:movoprive/features/authentication/login/login_phonenum.dart';
import '../../base/constants/app_images.dart';
import '../../base/app_widget/gradient_btn.dart'; // Import the GradientButton

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with text at the top
              Image.asset(AppImages.logowithtext_img, width: 150),
              const SizedBox(height: 50), // Space between logo and buttons
              // "Let's Get Started" button
              GradientButton(
                text: "Join as a Passenger",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginEmailScreen()),
                  );
                },
              ),
              const SizedBox(height: 20), // Space between buttons
              // "Login with Phone Number" button
              GradientButton(
                text: "Join as a Chauffeur",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => D_LoginEmailScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
