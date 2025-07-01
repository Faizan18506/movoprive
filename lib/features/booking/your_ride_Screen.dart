import 'package:flutter/material.dart';
import 'package:movoprive/features/booking/Confirm_booking.dart';

import '../settings/widgets/GradientButton2.dart';



class YourRideBookingScreen extends StatefulWidget {
  const YourRideBookingScreen({Key? key}) : super(key: key);

  @override
  State<YourRideBookingScreen> createState() => _YourRideBookingScreenState();
}

class _YourRideBookingScreenState extends State<YourRideBookingScreen> {
  bool _isOneWay = true;
  final FocusNode _pickupFocusNode = FocusNode();
  final FocusNode _destinationFocusNode = FocusNode();

  @override
  void dispose() {
    _pickupFocusNode.dispose();
    _destinationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // Prevents keyboard from pushing content
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Ride type header
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Your rides',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Ride type selector with underline for active tab
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => _isOneWay = true),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _isOneWay ? Colors.white : Colors.transparent,
                                      borderRadius: BorderRadius.circular(25),
                                      border: _isOneWay
                                          ? Border.all(color: Colors.white, width: 1.5)
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'One way',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: _isOneWay ?Colors.black : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => _isOneWay = false),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: !_isOneWay ? Colors.white : Colors.transparent,
                                      borderRadius: BorderRadius.circular(25),
                                      border: !_isOneWay
                                          ? Border.all(color: Colors.white, width: 1.5)
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Round trip',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: !_isOneWay ? Colors.black : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Purple underline for active tab
                        if (_isOneWay)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              height: 2,
                              color: Color(0xFF410081),
                            ),
                          )
                        else
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              height: 2,
                              color: Color(0xFF410081),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Pickup and destination input fields - now pixel perfect
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Pickup route visualization
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 40,
                              color: Colors.grey,
                            ),
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              // Pickup input - enhanced with focus handling
                              Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: Color(0xFF410081), width: 1.5),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        focusNode: _pickupFocusNode,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter pickup address',
                                          hintStyle: TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlignVertical: TextAlignVertical.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Destination input - enhanced with focus handling
                              Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.grey[300],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        focusNode: _destinationFocusNode,
                                        decoration: const InputDecoration(
                                          hintText: 'Where to?',
                                          hintStyle: TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlignVertical: TextAlignVertical.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Select on map option
              Row(
                children: [
                  Icon(Icons.map_outlined, color: Colors.black),
                  const SizedBox(width: 8),
                  const Text(
                    'Select on map',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Current location card with map preview
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'My Current Location',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Map container placeholder
                    Container(
                      height: 180, // Adjusted to match design
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        color: Colors.grey[200],
                      ),
                      child: Stack(
                        children: [
                          // Map placeholder - replace with your asset image path
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/home_screen/map.png'), // Your actual image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Location pin
                          Center(
                            child: Icon(
                              Icons.location_on,
                              color: Color(0xFF410081),
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Using Expanded with a Column to push button to bottom
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Confirm ride button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Center(
                        child: GradientButton2(
                          text: "Confirm Ride",
                          onPressed: () {
                            // Dismiss keyboard if open
                            FocusScope.of(context).unfocus();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ConfirmPayScreen()),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}