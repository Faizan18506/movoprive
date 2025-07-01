import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/Driver_side/D_authentication/D_screens/D_partenerscreen_2.dart';


import '../D_services/d_auth_service.dart';

class D_PartnerOnboardingScreen extends StatefulWidget {
  final String userId;

  const D_PartnerOnboardingScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<D_PartnerOnboardingScreen> createState() => _PartnerOnboardingScreenState();
}

class _PartnerOnboardingScreenState extends State<D_PartnerOnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final DAuthService _authService = DAuthService();
  bool isLoading = false;

  // Dropdown options
  final List<String> companyTypes = [
    'LLC',
    'Corporation',
    'Partnership',
    'Sole Proprietorship',
    'Other',
  ];
  final List<String> states = [
    'California',
    'New York',
    'Texas',
    'Florida',
    'Illinois',
    'Other',
  ];
  Map<String, File?> documentFiles = {
    'Manitoba Class 5F Driver\'s Licence': null,
    'Limousine Chauffeur Licence (if applying for Mova Prive)': null,
    'MPI Driver\'s Abstract': null,
    'Criminal Background Check': null,
    'Child Abuse Registry Check': null,
    'Proof of Work Eligibility': null,
  };
  // Selected values
  String? selectedCompanyType;
  String? selectedState;
  bool isCompanyMode = true;
  File? _profileImage;

  // Form controllers for company information
  final TextEditingController companyInfoController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController taxIdController = TextEditingController();
  final TextEditingController vatIdController = TextEditingController();
  final TextEditingController businessRegController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('Partner Onboarding Screen initialized with userId: ${widget.userId}');
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
                      7,
                          (index) => _buildProgressDot(index, 0),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Introduction text
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                        const TextSpan(text: 'Thank you '),
                        TextSpan(
                          text: 'Dr.Einstein',
                          style: TextStyle(color: Colors.purple[700]),
                        ),
                        const TextSpan(text: ' for choosing to partner with '),
                        TextSpan(
                          text: 'Movo Privé',
                          style: TextStyle(color: Colors.purple[700]),
                        ),
                        const TextSpan(
                          text:
                          '. You have selected California as your primary city of operations.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ADD TOGGLE BUTTONS HERE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildToggleButton('Company Information', isCompanyMode, () {
                        setState(() {
                          isCompanyMode = true;
                        });
                      }),
                      const SizedBox(width: 10),
                      _buildToggleButton('Individual Information', !isCompanyMode, () {
                        setState(() {
                          isCompanyMode = false;
                        });
                      }),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // CONDITIONALLY DISPLAY DIFFERENT FORMS BASED ON SELECTION
                  if (isCompanyMode) ...[
                    // Company Information Form
                    const Text(
                      'Please provide the following mandatory information: Company name, Legal form, Country, City, Street and Postal Code.',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 24),

                    // Company Information Section Title
                    const Text(
                      'Company Information',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // Company Information
                    _buildTextField('Company Information', controller: companyInfoController),
                    const SizedBox(height: 10),

                    // Company Type Dropdown
                    _buildDropdown(
                      'Company Type (Legal Form)',
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
                    const Text(
                      'Company Address',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // Country
                    _buildTextField('Country', controller: countryController),
                    const SizedBox(height: 10),

                    // Street
                    _buildTextField('Street', controller: streetController),
                    const SizedBox(height: 10),

                    // Zip/Postal code
                    _buildTextField('Zip/Postal code', controller: zipCodeController),
                    const SizedBox(height: 10),

                    // City and State in a row

                        // City field - takes 1/2 of the width
                    _buildTextField('City', controller: cityController),
                        const SizedBox(width: 10),
                        // State dropdown - takes 1/2 of the width


                    const SizedBox(height: 10),

                    // Tax Identification Number with asterisk for required
                    _buildTextField(
                      'Tax Identification Number',
                      isRequired: true,
                      controller: taxIdController,
                    ),
                    const SizedBox(height: 10),

                    // VAT ID/Number with asterisk for required
                    _buildTextField(
                      'VAT ID/Number',
                      isRequired: true,
                      controller: vatIdController,
                    ),
                    const SizedBox(height: 10),

                    // Business Registration Number with asterisk for required
                    _buildTextField(
                      'Business Registration Number',
                      isRequired: true,
                      controller: businessRegController,
                    ),
                  ] else ...[
                    // Individual Information Form
                    const Text(
                      'Please provide your individual information and required documents below.',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 24),

                    // Individual Information Section Title
                    const Text(
                      'Individual Information',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // Profile Picture Section
                    Center(
                      child: Column(
                        children: [
                          // Profile picture container
                          GestureDetector(
                            onTap: () {
                              // Add image picker functionality here
                              _pickProfileImage();
                            },
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.purple[700]!, width: 2),
                                image: _profileImage != null
                                    ? DecorationImage(
                                  image: FileImage(_profileImage!),
                                  fit: BoxFit.cover,
                                )
                                    : null,
                              ),
                              child: _profileImage == null
                                  ? Icon(
                                Icons.add_a_photo,
                                size: 40,
                                color: Colors.purple[700],
                              )
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Profile Picture',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tap to select',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Document Upload Section Title
                    const Text(
                      'Required Documents',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please upload the following documents:',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 16),

                    // Document Upload Fields
                    _buildDocumentUploadField('Manitoba Class 5F Driver\'s Licence'),
                    const SizedBox(height: 10),

                    _buildDocumentUploadField('Limousine Chauffeur Licence (if applying for Mova Prive )'),
                    const SizedBox(height: 10),

                    _buildDocumentUploadField('MPI Driver\'s Abstract'),
                    const SizedBox(height: 10),

                    _buildDocumentUploadField('Criminal Background Check'),
                    const SizedBox(height: 10),

                    _buildDocumentUploadField('Child Abuse Registry Check'),
                    const SizedBox(height: 10),

                    _buildDocumentUploadField('Proof of Work Eligibility'),
                  ],
                  const SizedBox(height: 16),

                  // FAQ section
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'For more information regarding Partner Onboarding, you can visit our FAQ page ',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle here link action
                        },
                        child: Text(
                          'here',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.purple[700],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Divider
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 16),

                  // Next button at the bottom
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: isLoading ? null : _submitCompanyInfo,
                      child: Container(
                        width: 95,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
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
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Helper method to build document upload field
  Widget _buildDocumentUploadField(String documentType) {
    bool isUploaded = documentFiles[documentType] != null;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    documentType,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  if (isUploaded)
                    Text(
                      'File uploaded',
                      style: TextStyle(fontSize: 11, color: Colors.green),
                    ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _pickDocumentFile(documentType),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isUploaded ? Colors.green : Colors.purple[700],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isUploaded ? 'Change' : 'Upload',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
// Method to pick profile image
  Future<void> _pickProfileImage() async {
    try {
      // Create an instance of ImagePicker
      final ImagePicker picker = ImagePicker();
      
      // Use the pickImage method from image_picker with improved error handling
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Slightly compress the image for better performance
      );

      // Only process if an image was selected
      if (image != null && image.path.isNotEmpty) {
        setState(() {
          _profileImage = File(image.path);
        });
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile image updated successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error picking image: $e');
      // Show detailed error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

// Method to pick document file
  Future<void> _pickDocumentFile(String documentType) async {
    try {
      // Use a simpler approach with file_picker that has better compatibility
      // with newer Flutter versions
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      // Process the result only if files were selected
      if (result != null && result.files.isNotEmpty && result.files.single.path != null) {
        final path = result.files.single.path!;
        setState(() {
          documentFiles[documentType] = File(path);
        });
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Document uploaded successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error picking file: $e');
      // Show detailed error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick file: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
// Add this new helper method for the toggle buttons
  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple[700] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.purple[700]!),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.purple[700],
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
// Helper method to build text fields with smaller height
  Widget _buildTextField(String label, {bool isRequired = false, TextEditingController? controller}) {
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
          height: 35,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
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
            style: const TextStyle(fontSize: 13),
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
          style: const TextStyle(fontSize: 11),
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
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.purple[700] : Colors.grey[300],
            border: isCurrent
                ? Border.all(color: Colors.purple[700]!, width: 2)
                : null,
          ),
        ),
        // Line between dots (except for the last one)
        if (index < 6)
          Container(
            width: 20,
            height: 2,
            color: isActive && index < currentStep
                ? Colors.purple[700]
                : Colors.grey[300],
          ),
      ],
    );
  }

  Future<void> _submitCompanyInfo() async {
    if (!_formKey.currentState!.validate()) {
      print('Form validation failed');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      if (isCompanyMode) {
        // Validate company information
        if (selectedCompanyType == null) {
          throw Exception('Please select a company type');
        }

        print('Submitting company information...');
        
        final response = await _authService.registerCompanyInfo(
          userId: widget.userId,
          companyInformation: companyInfoController.text,
          companyType: selectedCompanyType!,
          country: countryController.text,
          street: streetController.text,
          zipCode: int.parse(zipCodeController.text),
          city: cityController.text,
          taxIdentificationNumber: int.parse(taxIdController.text),
          vatId: int.parse(vatIdController.text),
          businessRegistrationNumber: int.parse(businessRegController.text),
        );

        print('Company information submitted successfully');
      } else {
        // Validate individual information
        if (_profileImage == null) {
          throw Exception('Please upload a profile picture');
        }

        // Build documents map with non-nullable File values and correct keys
        final Map<String, File> documents = {
          'fiveFDriverLicense': documentFiles['Manitoba Class 5F Driver\'s Licence']!,
          'lamousineLicense': documentFiles['Limousine Chauffeur Licence (if applying for Mova Prive )']!,
          'MPIDriver': documentFiles['MPI Driver\'s Abstract']!,
          'criminalBackgroundCheck': documentFiles['Criminal Background Check']!,
          'childAbuseCheck': documentFiles['Child Abuse Registry Check']!,
          'workEligibility': documentFiles['Proof of Work Eligibility']!,
        };

        // Check for missing documents
        final missingDocs = documents.entries.where((e) => e.value == null).map((e) => e.key).toList();
        if (missingDocs.isNotEmpty) {
          throw Exception('Please upload all required documents: \\n${missingDocs.join(', ')}');
        }

        print('Submitting profile info...');
        final response = await _authService.registerProfileInfo(
          userId: widget.userId,
          profilePicture: _profileImage!,
          documents: documents,
        );
        print('Profile info submitted successfully: \\n${response['message']}');
      }

      if (mounted) {
        // Navigate to next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => D_2PartnerOnboardingScreen(
              userId: widget.userId,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error submitting information: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
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
    companyInfoController.dispose();
    countryController.dispose();
    streetController.dispose();
    zipCodeController.dispose();
    cityController.dispose();
    taxIdController.dispose();
    vatIdController.dispose();
    businessRegController.dispose();
    super.dispose();
  }
}