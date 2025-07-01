import 'package:flutter/material.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/Driver_side/D_authentication/D_screens/D_change_pass_screen.dart';
import 'package:movoprive/features/Driver_side/D_authentication/D_screens/D_register.dart';
import 'package:movoprive/features/navigation/screens/Driver_side_dashboard.dart';
import 'package:movoprive/features/navigation/screens/main_screen.dart';
import '../D_services/d_auth_service.dart';

import '../../../../base/app_widget/CustomTextField.dart';
import '../../../../base/app_widget/gradient_btn.dart';
import '../D_widgets/GradientFooter.dart';
import 'D_register_detail.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:geolocator/geolocator.dart';

class D_LoginEmailScreen extends StatefulWidget {
  const D_LoginEmailScreen({Key? key}) : super(key: key);

  @override
  State<D_LoginEmailScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<D_LoginEmailScreen> {
  bool rememberMe = false;
  bool isLoading = false;
  final DAuthService _authService = DAuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() { isLoading = true; });
    try {
      final response = await _authService.driverLogin(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      print('Login API success: \n${response['message']}');
      print('Full login response: $response');

      // 1. Connect socket
      print('Connecting to socket...');
      SocketService().connect();
      print('Socket connection attempted.');

      // 2. Get current location
      print('Fetching current location...');
      Position position;
      try {
        position = await getCurrentLocation();
        print('Current location fetched: lat=${position.latitude}, lng=${position.longitude}');
      } catch (e) {
        print('Location error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permission is required to continue. Please enable it in settings.')),
        );
        setState(() { isLoading = false; });
        return;
      }

      // 3. Extract and check driverId
      final driverId = response['data'] != null ? (response['data']['driverId'] ?? response['data']['_id']) : (response['driverId'] ?? response['_id']);
      print('Extracted driverId: $driverId');
      if (driverId == null) {
        print('ERROR: driverId is missing from login response!');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login response missing driver ID. Please contact support.')),
        );
        setState(() { isLoading = false; });
        return;
      }
      print('Emitting updateLocation for driverId: $driverId');
      SocketService().emitUpdateLocation(
        driverId: driverId,
        lat: position.latitude,
        lng: position.longitude,
      );
      print('updateLocation event emitted.');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DriverMainScreen()),
      );
    } catch (e) {
      print('Login API error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() { isLoading = false; });
    }
  }

  Future<void> _startRegistration() async {
    setState(() {
      isLoading = true;
    });

    try {
      print('Starting registration process...');
      final response = await _authService.startDriverRegistration();
      
      if (mounted) {
        // Navigate to register detail screen with the userId
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => D_RegisterDetailScreen(
              userId: response['data']['userId'],
            ),
          ),
        );
      }
    } catch (e) {
      print('Error during registration start: $e');
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo and company name as one image
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AppImages.logowithtext_img,
                          height: 220,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),

                    // "Log in to your Account" text aligned to the left
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),

                    // Welcome back text aligned to the left
                    RichText(
                      text: TextSpan(
                        text: 'Log in to start driving with ',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        children: [
                          TextSpan(
                            text: 'Movo Privé',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8B7500),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Email input field
                    CustomTextField(
                      label: 'Email Address*',
                      isPassword: false,
                      controller: emailController,
                    ),
                    const SizedBox(height: 12),
                    // Password input field
                    CustomTextField(
                      label: 'Password*',
                      isPassword: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 12),
                    // Login button
                    GradientButton(
                      text: isLoading ? "Logging in..." : "Login",
                      onPressed: isLoading ? null : _login,
                    ),
                    const SizedBox(height: 18),

                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => D_ChangePassScreen()),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8B7500),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // GradientFooter positioned at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: GradientFooter(
              onSignUpTap: _startRegistration,
            ),
          ),
        ],
      ),
    );
  }
}

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  IO.Socket? socket;

  SocketService._internal();

  void connect() {
    if (socket != null && socket!.connected) return;
    socket = IO.io('http://192.168.1.71:5001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket!.connect();
  }

  void emitUpdateLocation({required String driverId, required double lat, required double lng}) {
    final data = {
      "driverId": driverId,
      "lat": lat.toString(),
      "lng": lng.toString(),
    };
    print('Emitting updateLocation: $data');
    socket?.emit('updateLocation', data);
  }
}

Future<Position> getCurrentLocation() async {
  print('Checking location permission...');
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    print('Location permission denied. Requesting permission...');
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permission denied by user.');
      throw Exception("Location permissions are denied");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    print('Location permission permanently denied.');
    throw Exception("Location permissions are permanently denied, we cannot request permissions.");
  }

  print('Location permission granted. Fetching position...');
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

