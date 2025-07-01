import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movoprive/features/authentication/forgot_pasword/newpasward_screen.dart';
import 'package:movoprive/features/authentication/services/auth_service.dart';
import 'package:movoprive/base/app_widget/app_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/constants/app_images.dart';
import '../../../base/app_widget/gradient_btn.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  final AuthService _authService = AuthService();

  void _onOtpDigitEntered(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  Future<void> _verifyOtp() async {
    try {
      // Get the OTP from all controllers
      final otp = _controllers.map((controller) => controller.text).join();
      
      if (otp.length != 6) {
        AppToast.success('Please enter complete OTP');
        return;
      }

      // Get the userId from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('resetUserId');

      if (userId == null) {
        AppToast.success('Invalid user ID');
        return;
      }

      // Verify OTP with the userId
      await _authService.verifyResetOtp(otp, userId);

      if (mounted) {
        AppToast.success('OTP verified successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NewpaswardScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        AppToast.success(e.toString());
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Center(
                  child: Image.asset(
                    AppImages.logowithtext_img,
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 0),
                // "Check your SMS" text
                const Text(
                  'Check your Email',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                // Description text
                const Text(
                  "We've sent a 6-digit confirmation code to your email",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 48),
                // OTP boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => SizedBox(
                      width: 45,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        onChanged: (value) => _onOtpDigitEntered(value, index),
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 200),
                // Next button
                SizedBox(
                  width: double.infinity,
                  child: GradientButton(
                    text: "Next",
                    onPressed: _verifyOtp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}