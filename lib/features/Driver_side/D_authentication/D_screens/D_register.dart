// import 'package:flutter/material.dart';
// import 'package:movoprive/base/constants/app_images.dart';
// import 'package:movoprive/features/Driver_side/D_authentication/D_screens/D_login_screen.dart';
// import 'package:movoprive/features/Driver_side/D_authentication/D_screens/D_register_detail.dart';
// import 'package:movoprive/features/navigation/screens/main_screen.dart';
//
// import '../../../../base/app_widget/gradient_btn.dart';
// import '../D_widgets/GradientFooter.dart';
//
// class D_RegisterScreen extends StatefulWidget {
//   const D_RegisterScreen({Key? key}) : super(key: key);
//
//   @override
//   State<D_RegisterScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<D_RegisterScreen> {
//   bool rememberMe = false;
//   String? selectedCountry;
//   String? selectedCity;
//
//   // Sample data for dropdowns
//   final List<Map<String, dynamic>> countries = [
//     {'name': 'United States', 'flag': '🇺🇸'},
//     {'name': 'Canada', 'flag': '🇨🇦'},
//     {'name': 'United Kingdom', 'flag': '🇬🇧'},
//     {'name': 'Australia', 'flag': '🇦🇺'},
//     {'name': 'Germany', 'flag': '🇩🇪'},
//   ];
//
//   final Map<String, List<String>> citiesByCountry = {
//     'United States': ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Miami'],
//     'Canada': ['Toronto', 'Vancouver', 'Montreal', 'Calgary', 'Ottawa'],
//     'United Kingdom': [
//       'London',
//       'Manchester',
//       'Birmingham',
//       'Liverpool',
//       'Edinburgh',
//     ],
//     'Australia': ['Sydney', 'Melbourne', 'Brisbane', 'Perth', 'Adelaide'],
//     'Germany': ['Berlin', 'Munich', 'Hamburg', 'Frankfurt', 'Cologne'],
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // Logo and company name as one image
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Image.asset(
//                           AppImages.logowithtext_img,
//                           height: 220,
//                           fit: BoxFit.contain,
//                         ),
//                       ],
//                     ),
//
//                     // "Register" text aligned to the left
//                     const Text(
//                       'Register',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//
//                     // Welcome back text aligned to the left
//                     RichText(
//                       text: const TextSpan(
//                         text: 'Enter your detail to create an account',
//                         style: TextStyle(fontSize: 14, color: Colors.black),
//                       ),
//                     ),
//                     const SizedBox(height: 18),
//
//                     // Country Dropdown
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             isExpanded: true,
//                             value: selectedCountry,
//                             hint: Row(
//                               children: [
//                                 const Text(
//                                   "🇺🇸",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 const Text(
//                                   "Select Country",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ],
//                             ),
//                             icon: const Icon(Icons.keyboard_arrow_down),
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 selectedCountry = newValue;
//                                 selectedCity =
//                                     null; // Reset city when country changes
//                               });
//                             },
//                             items:
//                                 countries.map<DropdownMenuItem<String>>((
//                                   country,
//                                 ) {
//                                   return DropdownMenuItem<String>(
//                                     value: country['name'],
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           country['flag'],
//                                           style: const TextStyle(fontSize: 16),
//                                         ),
//                                         const SizedBox(width: 8),
//                                         Text(country['name']),
//                                       ],
//                                     ),
//                                   );
//                                 }).toList(),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 12),
//
//                     // City Dropdown
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             isExpanded: true,
//                             value: selectedCity,
//                             hint: Row(
//                               children: [
//                                 const Text(
//                                   "🏙️",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 const Text(
//                                   "Select City",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ],
//                             ),
//                             icon: const Icon(Icons.keyboard_arrow_down),
//                             onChanged:
//                                 selectedCountry == null
//                                     ? null
//                                     : (String? newValue) {
//                                       setState(() {
//                                         selectedCity = newValue;
//                                       });
//                                     },
//                             items:
//                                 selectedCountry == null
//                                     ? []
//                                     : citiesByCountry[selectedCountry]!
//                                         .map<DropdownMenuItem<String>>((
//                                           String city,
//                                         ) {
//                                           return DropdownMenuItem<String>(
//                                             value: city,
//                                             child: Text(city),
//                                           );
//                                         })
//                                         .toList(),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 12),
//
//                     // Login button
//                     GradientButton(
//                       text: "Next",
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => D_RegisterDetailScreen()),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 18),
//
//                     InkWell(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => D_LoginEmailScreen()),
//                         );
//                       },
//                       child: const Center(
//                         child: Text(
//                           'Already have an account? Log in',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Color(0xFF8B7500),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           // GradientFooter is not being used here as per your comment
//         ],
//       ),
//     );
//   }
// }
