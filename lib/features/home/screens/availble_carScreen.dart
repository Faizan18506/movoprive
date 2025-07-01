import 'package:flutter/material.dart';
import 'package:movoprive/features/booking/PickupLocationScreen.dart';

import '../../booking/your_ride_Screen.dart';

class AvailableCarsScreen extends StatelessWidget {
  final List availableDrivers;
  const AvailableCarsScreen({Key? key, required this.availableDrivers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.normal),
        ),
        titleSpacing: -10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Available cars for ride',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF6B4F4F),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${availableDrivers.length} cars found',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),

            // Driver Cards
            Expanded(
              child: ListView.builder(
                itemCount: availableDrivers.length,
                itemBuilder: (context, index) {
                  final driver = availableDrivers[index];
                  print('Driver card: $driver');
                  return _buildDriverCard(context, driver);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverCard(BuildContext context, Map driver) {
    // Choose car image based on carType
    String carType = driver['carType'] ?? '';
    String imagePath = 'assets/driver_Side/car_1.png';
    if (carType.toLowerCase().contains('premium')) {
      imagePath = 'assets/driver_Side/car_2.png';
    } else if (carType.toLowerCase().contains('priv')) {
      imagePath = 'assets/driver_Side/car_3.png';
    }
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6E1E1),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carType,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D2D2D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Automatic',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF5A4444),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Color(0xFF5A4444),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Text(
                          '3 seats',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF5A4444),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Color(0xFF5A4444),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Text(
                          'Octane',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF5A4444),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Color(0xFF5A4444),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${driver['distance'] != null ? driver['distance'].toStringAsFixed(0) : 'N/A'} m (${driver['etaMinutes'] ?? 'N/A'} mins away)',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF5A4444),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset(
                  imagePath,
                  width: 100,
                  height: 50,
                ),
              ],
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: ()  {
                print('Book driver: ${driver['_id']}');
                // Implement booking logic here
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'BOOK ',
                          style: TextStyle(
                            color: Color(0xFF6B4F4F),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: 'NOW',
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}