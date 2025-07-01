import 'package:flutter/material.dart';



class MyRidesScreen extends StatefulWidget {
  const MyRidesScreen({Key? key}) : super(key: key);

  @override
  _RidesScreenState createState() => _RidesScreenState();
}

class _RidesScreenState extends State<MyRidesScreen> {
  bool isPastSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and title
              Row(
                children: [
                  // Back button in square with purple border
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.purple,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Title
                  const Text(
                    'My Rides',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Tab selector
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPastSelected = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Past',
                            style: TextStyle(
                              fontWeight: isPastSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 3,
                            color: isPastSelected ? Colors.black : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPastSelected = false;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Upcoming',
                            style: TextStyle(
                              fontWeight: !isPastSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 3,
                            color: !isPastSelected ? Colors.black : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Content based on selected tab
              Expanded(
                child: isPastSelected ? _buildPastRides() : _buildUpcomingRides(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPastRides() {
    return ListView(
      children: [
        _buildRideCard(
          name: 'Janet Precious',
          id: 'Alto 500',
          amount: '\$100.00',
          isPositive: false,
          originCity: 'Chicago, IL',
          destinationCity: 'Houston, TX',
          paymentMethod: 'Wallet',
          date: 'Today | 10:30 AM',
          imageAsset: 'assets/driver_Side/icon_2.png',
        ),
        const SizedBox(height: 16),
        _buildRideCard(
          name: 'Henry Smith',
          id: 'HS1234',
          amount: '\$50.00',
          isPositive: false,
          originCity: 'San Diego, CA',
          destinationCity: 'San Jose, CA',
          paymentMethod: 'Visa',
          date: 'Today | 12:30 AM',
          imageAsset: 'assets/driver_Side/icon_3.png',
        ),
      ],
    );
  }

  Widget _buildUpcomingRides() {
    return ListView(
      children: [
        _buildRideCard(
          name: 'Janet Precious',
          id: 'Alto 500',
          amount: '\$100.00',
          isPositive: true,
          originCity: 'Chicago, IL',
          destinationCity: 'Houston, TX',
          paymentMethod: 'Wallet',
          date: 'Today | 10:30 AM',
          imageAsset: 'assets/driver_Side/chat_icon.png',
        ),
        const SizedBox(height: 16),
        _buildRideCard(
          name: 'Henry Smith',
          id: 'HS1234',
          amount: '\$50.00',
          isPositive: true,
          originCity: 'San Diego, CA',
          destinationCity: 'San Jose, CA',
          paymentMethod: 'Visa',
          date: 'Today | 12:30 AM',
          imageAsset: 'assets/driver_Side/chat_icon.png',
        ),
      ],
    );
  }

  Widget _buildRideCard({
      required String name,
      required String id,
      required String amount,
      required bool isPositive,
      required String originCity,
      required String destinationCity,
      required String paymentMethod,
      required String date,
      required String imageAsset,
    }) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Header with user info and amount
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // User image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imageAsset,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.person, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // User details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF2D0A53), Color(0xFF8B7500)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds),
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white, // Required for ShaderMask
                            ),
                          ),
                        ),
                        Text(
                          id,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Amount
                  Text(
                    amount,
                    style: TextStyle(
                      color: isPositive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, thickness: 1),

            // Locations
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // Origin
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        originCity,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Destination
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        destinationCity,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 1, thickness: 1),

            // Payment info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Payment label
                  const Text(
                    'Payment\nDate Time',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  // Payment details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        paymentMethod,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
