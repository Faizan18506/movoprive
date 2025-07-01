import 'package:flutter/material.dart';
import 'package:movoprive/features/Driver_side/DashBoard/FilterOptionsScreen.dart';

class D_OffersScreen extends StatelessWidget {
  // You can replace this with your own asset path
  final String emptyImagePath;

  const D_OffersScreen({
    Key? key,
    this.emptyImagePath = 'assets/driver_Side/Empty_box.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Offers',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Filter action
            },
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const D_FilterOptionsScreen(),
                  ),);
              },
              child: const Text(
                'Filter',
                style: TextStyle(
                  color: Color(0xFF8A6E3D), // Golden brown color
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty offers image - using your custom asset
            Image.asset(
              emptyImagePath,
              width: 100,
              height: 100,
              color: Colors.grey[400],
            ),

            const SizedBox(height: 20),

            // No offers text
            const Text(
              'No offers available right now',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            // Description text
            const Text(
              'All offers have been set. New offers will be added as sas they come.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 25),

            // Refresh button
            TextButton(
              onPressed: () {
                // Refresh action
              },
              child: const Text(
                'Refresh',
                style: TextStyle(
                  color: Color(0xFF8A6E3D), // Golden brown color
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}