import 'package:flutter/material.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/authentication/forgot_pasword/otp_screen.dart';

import '../../../base/app_widget/CustomTextField.dart';
import '../../../base/app_widget/RememberForgotWidget.dart';
import '../../../base/app_widget/SocialLoginButton.dart';
import '../../../base/app_widget/gradient_btn.dart';



class ForgetPasswordPhonenumScreen extends StatefulWidget {
  const ForgetPasswordPhonenumScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPhonenumScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgetPasswordPhonenumScreen> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // Logo and company name as one image
                Stack(
                  alignment: Alignment.center, // Aligns children in the center
                  children: [
                    // Logo image
                    Center(
                      child: Image.asset(
                        AppImages.logowithtext_img,
                        height: 220,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // "Log in to your Account" text
                    Positioned(
                      bottom: 0, // Adjust this value to position the text
                      child: Text(
                        'Enter your Phone Number',
                        style: TextStyle(
                          fontSize: 28,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 100),
                // Email input field
                const CustomTextField(
                  label: 'Phone Number*',
                  isPassword: false,
                ),
                const SizedBox(height: 140),
                // Password input field

                GradientButton(
                  text: "Next",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => OtpVerificationScreen()),
                    );
                  }
                ),
                const SizedBox(height: 18),
                // Divider with OR

                const SizedBox(height: 24),

              ],
            ),
          ),
        ),
      ),
    );
  }
}



// Remember me and Forgot password widget
