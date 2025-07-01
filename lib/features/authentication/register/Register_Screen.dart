import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movoprive/base/constants/app_images.dart';

import '../../../base/app_widget/CustomTextField.dart';
import '../../../base/app_widget/SocialLoginButton.dart';
import '../../../base/app_widget/gradient_btn.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';
import '../../../base/app_widget/app_toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    print('RegisterScreen - Attempting to register');
    if (_formKey.currentState!.validate()) {
      print('RegisterScreen - Form validation successful');
      print('RegisterScreen - Form values:');
      print('  First Name: ${_firstNameController.text}');
      print('  Last Name: ${_lastNameController.text}');
      print('  Email: ${_emailController.text}');
      print('  Phone: ${_phoneController.text}');
      
      context.read<RegisterCubit>().register(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            phone: _phoneController.text,
            confirmPassword: _confirmPasswordController.text,
          );
    } else {
      print('RegisterScreen - Form validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        print('RegisterScreen - Received state: ${state.runtimeType}');
        if (state is RegisterSuccess) {
          print('RegisterScreen - Registration successful');
          print('RegisterScreen - Success message: ${state.message}');
          
          // Show success message with email verification info as toast
          AppToast.success('${state.message}\nPlease check your email for verification link.');

          // Navigate to login screen after a delay
          Future.delayed(const Duration(seconds: 5), () {
            if (mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (route) => false,
                arguments: {'showVerificationMessage': true},
              );
            }
          });
        } else if (state is RegisterError) {
          print('RegisterScreen - Registration failed');
          print('RegisterScreen - Error message: ${state.message}');
          AppToast.error(state.message);
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
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AppImages.logowithtext_img,
                          height: 220,
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create your Account',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Sign up to enjoy seamless booking experience.',
                                style: TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      label: 'Name*',
                      isPassword: false,
                      controller: _firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: 'Last Name*',
                      isPassword: false,
                      controller: _lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: 'Email*',
                      isPassword: false,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: 'Phone*',
                      isPassword: false,
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
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
                    const SizedBox(height: 8),
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        return GradientButton(
                          text: "Sign Up",
                          isLoading: state is RegisterLoading,
                          onPressed: state is RegisterLoading ? null : _handleRegister,
                        );
                      },
                    ),
                    const SizedBox(height: 18),
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
                    const SizedBox(height: 18),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Remember me and Forgot password widget
