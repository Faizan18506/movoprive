import 'package:flutter/material.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/Driver_side/D_authentication/D_screens/D_6PartnerOnboardingScreen.dart';

class D_5PartnerOnboardingScreen extends StatefulWidget {
  final String userId;
  final String firstName;

  const D_5PartnerOnboardingScreen({
    Key? key,
    required this.userId,
    required this.firstName,
  }) : super(key: key);

  @override
  State<D_5PartnerOnboardingScreen> createState() =>
      _PartnerOnboardingScreenState();
}

class _PartnerOnboardingScreenState extends State<D_5PartnerOnboardingScreen> {
  final _formKey = GlobalKey<FormState>();


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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo and header section in a Stack
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Logo
                        Positioned(
                          top: 0,
                          child: Image.asset(
                            AppImages.logowithtext_img,
                            height: 140,
                          ),
                        ),
                        // Partner Onboarding Text overlaid on bottom half of logo
                        Positioned(
                          bottom: 20,
                          child: Text(
                            'Partner Onboarding',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Progress bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      8,
                      (index) => _buildProgressDot(index, 5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Form fields
                  Text(
                    'Partner Contract',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Please review our contract below and accept your contractual ',
                    style: TextStyle(fontSize: 11),
                  ),

                  // Introduction text
                  const SizedBox(height: 16),
                  // Contract Preview Container
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        // Contract Preview Header
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Contract Preview',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Contract Content
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Framework cooperation and Transportation Services Agreement',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                '(Hereinafter the "Partner Agreement")',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'by and between',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Partner Company:',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                widget.firstName,
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                'Austin Pop, 970000, USA',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                'Duly registered/ incorporated under the laws of USA',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                'VAT ID: AT123459876',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                'Represented by Abdullhammid duly authorized',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Hereinafter referred to as',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                '"Partner" and',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Movo Privé, ',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFAA8A00), // Gold color for Movo Privé
                                    ),
                                  ),
                                  const Text(
                                    'Feurigstrasse 59, 10827 Berlin, Germany',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Download link
                              GestureDetector(
                                onTap: () {
                                  // Handle download
                                },
                                child: Text(
                                  'click here to download a copy of your contractual agreement',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Sign contract button container
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          child: Column(
                            children: [
                              // "Click the Sign" button
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey[400]!),
                                ),
                                child: const Text(
                                  'Click the "Sign your Contract" button to begin',
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Sign contract button

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Verification message container with purple accent

                  // Street

                  // City and State in a row

                  // Tax Identification Number with asterisk for required
                  const SizedBox(height: 10),


                      // Previous button

                      const SizedBox(width: 12),

                      Padding(
                        padding: const EdgeInsets.only( bottom: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: ()  {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => D_6PartnerOnboardingScreen(
                                    userId: widget.userId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 95,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF333333), // Dark blue/black
                                    Color(0xFF2D0A53), // Deep purple
                                    Color(0xFF8B7500), // Gold/amber
                                  ],
                                  stops: [0.0, 0.3, 0.6],
                                ),
                              ),
                              child: Center(
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


              ),
            ),
          ),
        ),

    );
  }

  // Add this helper method at the bottom of the class

  // Helper method to build dropdowns with smaller height

  // Helper method to build progress dots
  Widget _buildProgressDot(int index, int currentStep) {
    bool isActive = index <= currentStep;
    bool isCurrent = index == currentStep;

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Color(0xFF2D0A53) : Colors.grey[300],
            border:
                isCurrent
                    ? Border.all(color: Colors.purple[700]!, width: 2)
                    : null,
          ),
        ),
        // Line between dots (except for the last one)
        if (index < 7)
          Container(
            width: 30,
            height: 2,
            color:
                isActive && index < currentStep
                    ? Colors.purple[700]
                    : Colors.grey[300],
          ),
      ],
    );
  }
}
