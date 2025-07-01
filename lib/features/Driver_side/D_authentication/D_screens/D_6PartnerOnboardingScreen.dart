import 'package:flutter/material.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/Driver_side/D_authentication/D_screens/D_7PartnerOnboardingScreen.dart';
import '../D_services/d_auth_service.dart';

class D_6PartnerOnboardingScreen extends StatefulWidget {
  final String userId;

  const D_6PartnerOnboardingScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<D_6PartnerOnboardingScreen> createState() =>
      _PartnerOnboardingScreenState();
}

class _PartnerOnboardingScreenState extends State<D_6PartnerOnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final DAuthService _authService = DAuthService();
  bool isLoading = false;

  // Dropdown options
  final List<String> companyTypes = [
    'Debit Card',
    'Credit Card',
    'Cash',

  ];
  final List<String> states = [
    'California',
    'New York',
    'Texas',
    'Florida',
    'Illinois',
    'Other',
  ];

  // Selected values
  String? selectedCompanyType;
  String? selectedState;
  bool? workedWithLuxeMotion = false;  // Default selection "No"
  bool? hasElectricVehicles = false;   // Default selection "No"
  bool? hasWomenChauffeurs = false;

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
                          (index) => _buildProgressDot(index, 6),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Introduction text
                  const Text(
                    'Partner Details ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Please provide bank details for receiving payment from Luxemotion in the future ',
                    style: TextStyle(fontSize: 11),
                  ),

                  const SizedBox(height: 12),

                  // Are there electric vehicles in your fleet?



                  // Company Type Dropdown
                  _buildDropdown(
                    '*Preferred Payment Method',
                    companyTypes,
                    selectedCompanyType,
                        (value) {
                      setState(() {
                        selectedCompanyType = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  // Company Address section



                  // Country


                  // Add this right after the Row containing License Number Plate and Vehicle VIN
                  const SizedBox(height: 24),

// Verification message container with purple accent

                  // Street

                  // City and State in a row


                  // Tax Identification Number with asterisk for required

                  const SizedBox(height: 10),





                  // Divider
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Previous button
                      GestureDetector(
                        onTap: () {
                          // Handle previous button press
                        },
                        child: Container(
                          width: 90,
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: const Text(
                              'Previous',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: isLoading ? null : _submitPreferredPaymentMethod,
                          child: Container(
                            width: 95,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF333333),   // Dark blue/black
                                  Color(0xFF2D0A53),   // Deep purple
                                  Color(0xFF8B7500),   // Gold/amber
                                ],
                                stops: [0.0, 0.3, 0.6],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                isLoading ? 'Saving...' : 'Next',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
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
    );
  }
  // Add this helper method at the bottom of the class
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5, right: 8),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Color(0xFF2D0A53),
              shape: BoxShape.circle,
            ),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Helper method to build text fields with smaller height
  Widget _buildTextField(String label, {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 11),
            children: [
              TextSpan(text: label),
              if (isRequired)
                const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 35, // Make the field height smaller
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10, // Reduced vertical padding
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.purple[700]!),
              ),
            ),
            style: const TextStyle(fontSize: 13), // Smaller text size
            validator: isRequired
                ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            }
                : null,
          ),
        ),
      ],
    );
  }

  // Helper method to build dropdowns with smaller height
  Widget _buildDropdown(
      String label,
      List<String> items,
      String? selectedValue,
      Function(String?) onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        // Use a simple dropdown button instead of form field for better compatibility
        Container(
          height: 35,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            hint: const Text('Select', style: TextStyle(fontSize: 13)),
            style: const TextStyle(fontSize: 13, color: Colors.black),
            underline: Container(), // Remove the default underline
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, size: 20),
          ),
        ),
      ],
    );
  }

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
            border: isCurrent
                ? Border.all(color: Colors.purple[700]!, width: 2)
                : null,
          ),
        ),
        // Line between dots (except for the last one)
        if (index < 7)
          Container(
            width: 30,
            height: 2,
            color: isActive && index < currentStep
                ? Colors.purple[700]
                : Colors.grey[300],
          ),
      ],
    );
  }

  // Add this method
  Future<void> _submitPreferredPaymentMethod() async {
    if (selectedCompanyType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a preferred payment method')),
      );
      return;
    }
    setState(() { isLoading = true; });
    try {
      print('Submitting preferred payment method...');
      final response = await _authService.registerDriverPreferredPaymentMethod(
        userId: widget.userId,
        preferredPaymentMethod: selectedCompanyType!,
      );
      print('Payment method API success: \\n${response['message']}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => D_7PartnerOnboardingScreen(
            userId: widget.userId,
          ),
        ),
      );
    } catch (e) {
      print('Payment method API error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() { isLoading = false; });
    }
  }
}
Widget _buildRadioQuestion(String question, bool? value, Function(bool?) onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        question,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Radio<bool>(
            value: true,
            groupValue: value,
            onChanged: onChanged,
            activeColor: Color(0xFF2D0A53),
          ),
          const Text('Yes', style: TextStyle(fontSize: 12)),
          const SizedBox(width: 20),
          Radio<bool>(
            value: false,
            groupValue: value,
            onChanged: onChanged,
            activeColor:Color(0xFF2D0A53),
          ),
          const Text('No', style: TextStyle(fontSize: 12)),
        ],
      ),
    ],
  );
}