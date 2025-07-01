import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movoprive/base/constants/app_images.dart';

import 'package:movoprive/features/authentication/otp/otp_verification_screen.dart';
import 'package:movoprive/features/authentication/forgot_pasword/with_email.dart';
import 'package:movoprive/features/authentication/login/login_phonenum.dart';
import 'package:movoprive/features/authentication/register/Register_Screen.dart';
import 'package:movoprive/features/authentication/services/auth_service.dart';
import 'package:movoprive/features/navigation/screens/main_screen.dart';
import 'package:movoprive/utils/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/app_widget/CustomTextField.dart';
import '../../../base/app_widget/RememberForgotWidget.dart';
import '../../../base/app_widget/SocialLoginButton.dart';
import '../../../base/app_widget/app_toast.dart';
import '../../../base/app_widget/gradient_btn.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({Key? key}) : super(key: key);

  @override
  State<LoginEmailScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginEmailScreen> {
  bool rememberMe = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  late LoginCubit _loginCubit;
  final String tag = 'LoginEmailScreen';

  @override
  void initState() {
    super.initState();
    _loginCubit = LoginCubit(_authService);
    AppLogger.i(tag, 'LoginScreen initialized');

    // Check if we came from email verification
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args['verificationSuccess'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your email has been successfully verified! You can now login.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    AppLogger.d(tag, 'LoginScreen disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginCubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          } else {
            // Close loading indicator if it's open
            Navigator.of(context, rootNavigator: true).pop();
            
            if (state is LoginSuccess) {
              AppLogger.i(tag, 'Login success. Navigating to next screen.');
              // Save email to SharedPreferences
              _saveEmail();
              
              // Check if OTP is required
              if (state.response.data.message.contains('OTP sent')) {
                AppLogger.i(tag, 'OTP is required. Navigating to OTP screen.');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpVerificationScreen(
                      userId: state.userId,

                    ),
                  ),
                );
              } else {
                AppLogger.i(tag, 'No OTP required. Navigating to main screen.');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              }
            } else if (state is LoginFailure) {
              AppLogger.e(tag, 'Login failure', state.error);
              // Show error message
              AppToast.success(state.error);
            }
          }
        },
        child: Scaffold(
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
                      // Logo and company name as one image
                      Stack(
                        alignment: Alignment.center,
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
                            bottom: 0,
                            child: Text(
                              'Log in to your Account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Welcome back text
                      Center(
                        child: const Text(
                          'Welcome back, please enter your details.',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Email input field
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
                      const SizedBox(height: 12),
                      // Password input field
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
                      // Remember me and Forgot password
                      RememberForgotWidget(
                        rememberMe: rememberMe,
                        onRememberChanged: (value) {
                          setState(() {
                            rememberMe = value;
                          });
                        },
                        onForgotPassword: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPasswordEmailScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      // Phone number login option
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPhonenumScreen(),
                            ),
                          );
                        },
                        child: Center(
                          child: const Text(
                            'Sign In with Phone Number',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Login button
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return GradientButton(
                            text: "Login",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                AppLogger.i(tag, 'Form validated, attempting login');
                                _loginCubit.loginWithEmail(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 18),
                      // Divider with OR
                      Row(
                        children: const [
                          Expanded(child: Divider(thickness: 1)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'OR',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Expanded(child: Divider(thickness: 1)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Social login options
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialLoginButton(
                            icon: AppImages.google_logo,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 16),
                          SocialLoginButton(
                            icon: AppImages.facebook_logo,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 16),
                          SocialLoginButton(
                            icon: AppImages.apple_logo,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // Register now text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account ? ',
                            style: TextStyle(color: Colors.black54),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Register Now',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', _emailController.text.trim());
    AppLogger.i(tag, 'User email saved to SharedPreferences');
  }
}

// Remember me and Forgot password widget
