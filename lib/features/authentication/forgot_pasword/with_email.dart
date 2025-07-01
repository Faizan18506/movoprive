import 'package:flutter/material.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/authentication/forgot_pasword/otp_screen.dart';
import 'package:movoprive/features/authentication/services/auth_service.dart';
import 'package:movoprive/base/app_widget/app_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/app_widget/CustomTextField.dart';
import '../../../base/app_widget/RememberForgotWidget.dart';
import '../../../base/app_widget/SocialLoginButton.dart';
import '../../../base/app_widget/gradient_btn.dart';

class ForgetPasswordEmailScreen extends StatefulWidget {
  const ForgetPasswordEmailScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordEmailScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgetPasswordEmailScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleForgotPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await _authService.forgotPassword(_emailController.text.trim());
        
        // Check if response has data and userId
        if (response != null && response['data'] != null && response['data']['userId'] != null) {
          // Store the userId for OTP verification
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('resetUserId', response['data']['userId']);

          if (mounted) {
            AppToast.success('OTP sent to your email');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OtpVerificationScreen()),
            );
          }
        } else {
          throw 'Invalid response from server';
        }
      } catch (e) {
        if (mounted) {
          AppToast.success(e.toString());
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              AppImages.logowithtext_img,
                              height: 220,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Text(
                              'Enter your Email',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 100),
                      CustomTextField(
                        label: 'Email Address*',
                        isPassword: false,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 140),

                      GradientButton(
                        text: "Next",
                        onPressed: _isLoading ? null : _handleForgotPassword,
                      ),
                      const SizedBox(height: 18),
                      // Divider with OR

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

// Remember me and Forgot password widget
