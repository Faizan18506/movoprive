import 'package:flutter/material.dart';
import 'package:movoprive/features/booking/Confirm_booking.dart';

import '../settings/widgets/GradientButton2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class YourRideBookingScreen extends StatefulWidget {
  final Map? driver;
  final String? carType;
  final double? pickupLat;
  final double? pickupLng;
  const YourRideBookingScreen({Key? key, this.driver, this.carType, this.pickupLat, this.pickupLng}) : super(key: key);

  @override
  State<YourRideBookingScreen> createState() => _YourRideBookingScreenState();
}

class _YourRideBookingScreenState extends State<YourRideBookingScreen> {
  bool _isOneWay = true;
  final FocusNode _pickupFocusNode = FocusNode();
  final FocusNode _destinationFocusNode = FocusNode();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  List<String> _pickupSuggestions = [];
  bool _showPickupSuggestions = false;
  List<String> _filteredSuggestions = [];
  bool _showSuggestions = false;
  String _sessionToken = '';
  // Use your actual API key here (from AndroidManifest.xml)
  static const String _googleApiKey = 'AIzaSyACOuXUnpj13y6IzpHsuvTXVt1seHVs3j0';

  @override
  void dispose() {
    _pickupFocusNode.dispose();
    _destinationFocusNode.dispose();
    _pickupController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _onPickupChanged(String value) async {
    if (value.isEmpty) {
      setState(() {
        _pickupSuggestions = [];
        _showPickupSuggestions = false;
      });
      return;
    }
    if (_sessionToken.isEmpty) {
      _sessionToken = DateTime.now().millisecondsSinceEpoch.toString();
    }
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${Uri.encodeComponent(value)}&key=$_googleApiKey&sessiontoken=$_sessionToken';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          setState(() {
            _pickupSuggestions = List<String>.from(
              data['predictions'].map((p) => p['description'] as String),
            );
            _showPickupSuggestions = _pickupSuggestions.isNotEmpty;
          });
        } else {
          setState(() {
            _pickupSuggestions = [];
            _showPickupSuggestions = false;
          });
        }
      } else {
        setState(() {
          _pickupSuggestions = [];
          _showPickupSuggestions = false;
        });
      }
    } catch (e) {
      setState(() {
        _pickupSuggestions = [];
        _showPickupSuggestions = false;
      });
    }
  }

  void _onPickupSuggestionTap(String suggestion) {
    setState(() {
      _pickupController.text = suggestion;
      _showPickupSuggestions = false;
    });
  }

  void _onDestinationChanged(String value) async {
    if (value.isEmpty) {
      setState(() {
        _filteredSuggestions = [];
        _showSuggestions = false;
      });
      return;
    }
    // Generate a session token for each session (optional, but recommended by Google)
    if (_sessionToken.isEmpty) {
      _sessionToken = DateTime.now().millisecondsSinceEpoch.toString();
    }
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${Uri.encodeComponent(value)}&key=$_googleApiKey&sessiontoken=$_sessionToken';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          setState(() {
            _filteredSuggestions = List<String>.from(
              data['predictions'].map((p) => p['description'] as String),
            );
            _showSuggestions = _filteredSuggestions.isNotEmpty;
          });
        } else {
          setState(() {
            _filteredSuggestions = [];
            _showSuggestions = false;
          });
        }
      } else {
        setState(() {
          _filteredSuggestions = [];
          _showSuggestions = false;
        });
      }
    } catch (e) {
      setState(() {
        _filteredSuggestions = [];
        _showSuggestions = false;
      });
    }
  }

  void _onSuggestionTap(String suggestion) {
    setState(() {
      _destinationController.text = suggestion;
      _showSuggestions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // Prevents keyboard from pushing content
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Booking summary
                Card(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Driver: ${widget.driver != null ? (widget.driver!['name'] ?? 'N/A') : 'N/A'}'),
                        Text('Car Type: ${widget.carType ?? 'N/A'}'),
                        Text('Pickup Location: (${widget.pickupLat ?? 'N/A'}, ${widget.pickupLng ?? 'N/A'})'),
                      ],
                    ),
                  ),
                ),
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
                                          controller: _pickupController,
                                          onChanged: _onPickupChanged,
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
                                if (_showPickupSuggestions)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(top: 4),
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: _pickupSuggestions.map((s) => ListTile(
                                        title: Text(s),
                                        onTap: () => _onPickupSuggestionTap(s),
                                      )).toList(),
                                    ),
                                  ),
                                const SizedBox(height: 16),
                                // Destination input - now styled the same as pickup
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
                                          focusNode: _destinationFocusNode,
                                          controller: _destinationController,
                                          onChanged: _onDestinationChanged,
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
                                if (_showSuggestions)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(top: 4),
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: _filteredSuggestions.map((s) => ListTile(
                                        title: Text(s),
                                        onTap: () => _onSuggestionTap(s),
                                      )).toList(),
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
                // Confirm ride button (no Expanded)
                SizedBox(height: 24),
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
        ),
      ),
    );
  }
}