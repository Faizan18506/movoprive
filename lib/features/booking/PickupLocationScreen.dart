import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movoprive/features/booking/your_ride_Screen.dart';
import 'package:movoprive/features/home/screens/availble_carScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../settings/widgets/GradientButton2.dart';

class PickupLocationScreen extends StatefulWidget {
  final String carType;
  const PickupLocationScreen({Key? key, required this.carType}) : super(key: key);

  @override
  State<PickupLocationScreen> createState() => _PickupLocationScreenState();
}

class _PickupLocationScreenState extends State<PickupLocationScreen> {
  GoogleMapController? _mapController;
  final LatLng _initialPosition = const LatLng(
    51.5074,
    -0.1278,
  ); // London coordinates
  late TextEditingController _locationController;
  Position? _currentPosition;
  String? _currentAddress;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
    _fetchCurrentLocationAndAddress();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _fetchCurrentLocationAndAddress() async {
    print('Fetching user current location...');
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied by user.');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print('Location permission permanently denied.');
      return;
    }
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('Current position: lat=${_currentPosition!.latitude}, lng=${_currentPosition!.longitude}');
    // For simplicity, just use lat/lng as address
    _currentAddress = '${_currentPosition!.latitude}, ${_currentPosition!.longitude}';
    _locationController.text = _currentAddress!;
    setState(() {});
  }

  void _onConfirm() {
    _handleConfirm();
  }

  Future<void> _handleConfirm() async {
    if (_currentPosition == null) {
      print('No current position available.');
      return;
    }
    setState(() { _isLoading = true; });
    final lat = _currentPosition!.latitude;
    final lng = _currentPosition!.longitude;
    final radius = 1000;
    final carType = widget.carType;
    final url = 'http://192.168.1.71:5001/api/v1/booking/availableDrivers/nearby?lat=$lat&lng=$lng&radius=$radius&carType=${Uri.encodeComponent(carType)}';
    print('Calling API: $url');
    try {
      final response = await http.get(Uri.parse(url));
      print('API response status: ${response.statusCode}');
      print('API response body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final data = jsonDecode(response.body);
          print('Decoded data: $data');
          final drivers = data['data'] != null && data['data']['drivers'] != null ? data['data']['drivers'] : [];
          print('Drivers extracted: $drivers');
          if (drivers.isEmpty) {
            print('No drivers found in the area.');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No available drivers found nearby. Please try again later.')),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AvailableCarsScreen(
                  availableDrivers: drivers,
                  carType: carType,
                  pickupLat: lat,
                  pickupLng: lng,
                ),
              ),
            );
          }
        } catch (e) {
          print('Exception during JSON parsing or navigation: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred. Please try again.')),
          );
        }
      } else {
        print('Failed to fetch available cars. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error calling availableDrivers API: $e');
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Map Container (2/3 of screen)
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14.0,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('pickup'),
                      position: _initialPosition,
                      infoWindow: const InfoWindow(title: 'Pickup Location'),
                    ),
                  },
                ),

                // Set pickup text
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: const Text(
                    "Set pickup on map",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Location input section (1/3 of screen)
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Enter Location field
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFF000000), // Gold color
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Color(0xFF410081),
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: _locationController,
                              decoration: InputDecoration(
                                hintText: "Enter Location",
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // England field
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFF000000), // Gold color
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Expanded(
                      //   child: Container(
                      //     height: 40,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(16),
                      //       color: Colors.grey[200],
                      //     ),
                      //     padding: const EdgeInsets.symmetric(horizontal: 16),
                      //     child: const Align(
                      //       alignment: Alignment.centerLeft,
                      //       child: Text(
                      //         "England",
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: 16,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),

                  // Confirm button
                  GradientButton2(
                    text: _isLoading ? "Loading..." : "Confirm",
                    onPressed: _isLoading ? null : _onConfirm,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
