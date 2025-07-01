import 'package:flutter/material.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/Driver_side/D_authentication/D_screens/D_PartnerOnboardingScreen.dart';
import 'package:movoprive/features/Driver_side/D_authentication/D_screens/D_login_screen.dart';
import 'package:movoprive/features/navigation/screens/main_screen.dart';
import 'package:country_picker/country_picker.dart';
import '../D_services/d_auth_service.dart';

import '../../../../base/app_widget/gradient_btn.dart';
import '../D_widgets/GradientFooter.dart';

class D_RegisterDetailScreen extends StatefulWidget {
  final String userId;
  
  const D_RegisterDetailScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<D_RegisterDetailScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<D_RegisterDetailScreen> {
  String? selectedSource;
  String? selectedRepresentation;
  Country? selectedCountry;
  bool isLoading = false;
  final DAuthService _authService = DAuthService();

  // Form controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  Future<void> registerDriver() async {
    if (!_formKey.currentState!.validate()) {
      print('Form validation failed');
      return;
    }

    if (selectedCountry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a country code')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Format phone number by removing any spaces or special characters
      String phoneNumber = phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
      
      // Add '+' symbol to the country code
      String formattedPhone = '+' + selectedCountry!.phoneCode.replaceAll('+', '') + phoneNumber;
      
      print('Attempting to register with phone: $formattedPhone');

      final response = await _authService.registerDriver(
        userId: widget.userId,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: formattedPhone,
        confirmPassword: confirmPasswordController.text,
        driverType: selectedSource!,
        rideType: selectedRepresentation!,
      );

      print('Registration successful: ${response['message']}');
      
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => D_PartnerOnboardingScreen(
              userId: widget.userId,
            ),
          ),
        );
      }
    } catch (e) {
      print('Registration error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
                      // Logo and company name as one image
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            AppImages.logowithtext_img,
                            height: 180,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),

                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const Text(
                        'Enter your details to create an account',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const SizedBox(height: 16),

                      // First Name Field
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.black,
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 24,
                                minHeight: 24,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Last Name Field
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.black,
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 24,
                                minHeight: 24,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Email Field
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 24,
                                minHeight: 24,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
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
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Driver Type Dropdown
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedSource,
                            decoration: const InputDecoration(
                              hintText: 'Driver Type',
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.directions_car,
                                color: Colors.black,
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 24,
                                minHeight: 24,
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'movp prive',
                                child: Text('movp prive'),
                              ),
                              DropdownMenuItem(
                                value: 'movo classic',
                                child: Text('movo classic'),
                              ),
                              DropdownMenuItem(
                                value: 'movo premium',
                                child: Text('movo premium'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedSource = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a driver type';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Ride Type Dropdown
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedRepresentation,
                            decoration: const InputDecoration(
                              hintText: 'Ride Type',
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.directions,
                                color: Colors.black,
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 24,
                                minHeight: 24,
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'city rides',
                                child: Text('city rides'),
                              ),
                              DropdownMenuItem(
                                value: 'by the hour',
                                child: Text('by the hour'),
                              ),
                              DropdownMenuItem(
                                value: 'party bus',
                                child: Text('party bus'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedRepresentation = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a ride type';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Phone Number with Country Code
                      Row(
                        children: [
                          // Country Code Button
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    setState(() {
                                      selectedCountry = country;
                                    });
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 12.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (selectedCountry != null) ...[
                                      Text(
                                        selectedCountry!.flagEmoji,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        selectedCountry!.phoneCode,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ] else ...[
                                      const Icon(
                                        Icons.phone_android,
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text("Code"),
                                    ],
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Phone Number Field
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: TextFormField(
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    hintText: 'Phone number',
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Password Field
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.black,
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 24,
                                minHeight: 24,
                              ),
                            ),
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
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Confirm Password Field
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.black,
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 24,
                                minHeight: 24,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Next Button
                      GradientButton(
                        text: isLoading ? "Registering..." : "Next",
                        onPressed: isLoading ? null : registerDriver,
                      ),
                      const SizedBox(height: 18),

                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => D_LoginEmailScreen(),
                            ),
                          );
                        },
                        child: const Center(
                          child: Text(
                            'Already have an account? Log in',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8B7500),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
