import 'package:flutter/material.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/authentication/login/login_email.dart';
import 'package:movoprive/features/authentication/services/auth_service.dart';
import 'package:movoprive/base/app_widget/app_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/app_widget/CustomTextField.dart';
import '../../../base/app_widget/RememberForgotWidget.dart';
import '../../../base/app_widget/SocialLoginButton.dart';
import '../../../base/app_widget/gradient_btn.dart';

class NewpaswardScreen extends StatefulWidget {
  const NewpaswardScreen({Key? key}) : super(key: key);

  @override
  State<NewpaswardScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<NewpaswardScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('resetToken');
        
        if (token == null) {
          AppToast.success('Invalid reset token');
          return;
        }

        await _authService.resetPassword(
          _passwordController.text.trim(),
          _confirmPasswordController.text.trim(),
          token,
        );

        if (mounted) {
          AppToast.success('Password reset successful');
          // Clear the reset token
          await prefs.remove('resetToken');
          await prefs.remove('resetUserId');
          
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginEmailScreen()),
            (route) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          AppToast.success(e.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                          'Set your New Password',
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
                    label: 'Password*',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'Confirm Password*',
                    isPassword: true,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 80),

                  GradientButton(
                    text: "Next",
                    onPressed: _handleResetPassword,
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Remember me and Forgot password widget
