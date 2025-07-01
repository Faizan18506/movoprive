import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movoprive/base/app_widget/gradient_btn.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/authentication/otp/cubit/otp_cubit.dart';
import 'package:movoprive/features/authentication/otp/cubit/otp_state.dart';
import 'package:movoprive/features/navigation/screens/main_screen.dart';
import 'package:movoprive/utils/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String userId;
  
  const OtpVerificationScreen({
    Key? key, 
    required this.userId,
  }) : super(key: key);

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
  
  final String tag = 'OtpVerificationScreen';
  late OtpCubit _otpCubit;
  String _email = '';
  
  @override
  void initState() {
    super.initState();
    _otpCubit = BlocProvider.of<OtpCubit>(context);
    _loadUserEmail();
    AppLogger.i(tag, 'OTP Verification Screen initialized for userId: ${widget.userId}');
  }
  
  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('userEmail') ?? 'your email';
    });
  }

  void _onOtpDigitEntered(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }
  
  String _getFullOtp() {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    AppLogger.d(tag, 'OTP Verification Screen disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpLoading) {
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
          
          if (state is OtpSuccess) {
            AppLogger.i(tag, 'OTP verification successful, navigating to Main Screen');
            // Navigate to Main Screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          } else if (state is OtpFailure) {
            AppLogger.e(tag, 'OTP verification failed', state.error);
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('OTP verification failed: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
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
                // "Check your Email" text
                const Text(
                  'Check your Email',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                // Description text with bold email
                RichText(
                  text: TextSpan(
                    text: "We've sent a 6-digit confirmation code to\n",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: _email,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
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
                const Spacer(),
                // Verify button
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<OtpCubit, OtpState>(
                    builder: (context, state) {
                      return GradientButton(
                        text: "Verify",
                        onPressed: () {
                          final otp = _getFullOtp();
                          if (otp.length == 6) {
                            AppLogger.i(tag, 'Attempting OTP verification');
                            _otpCubit.verifyOtp(widget.userId, otp);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid 6-digit OTP'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 