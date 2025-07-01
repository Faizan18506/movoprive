import 'package:flutter/material.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/Driver_side/DashBoard/D_ProfileScreen.dart';
import 'package:movoprive/features/Driver_side/DashBoard/newsfeeds_update.dart';
import 'package:movoprive/features/Driver_side/Maps/Map_screen.dart';
import 'package:movoprive/features/settings/widgets/GradientButton2.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Container(
              color: Colors.white,
            ),

            // Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top section with logo and icons
                const TopSection(),

                // Greeting text - moved closer to the top section
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good afternoon,',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Adam',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // News and Updates card - moved upward with less bottom padding
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: InkWell(
                    onTap: ()  {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => D_NewsFeedScreen()),
                      );
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF3D2D5C),
                            Color(0xFFB3922E),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 20,
                            top: 25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(height: 10),
                                Text(
                                  'News and Updates',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'have a new home',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 15,
                            top: 40,
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          Positioned(
                            left: 12,
                            top: 12,
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ),
               Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: GradientButton2(
                    text: "Check Rides",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TourGuideMap()),
                      );
                    },
                  ),
               )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SizedBox(
        height: 120, // Reduced height to move content up
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Left hamburger menu (independent positioning)
            Positioned(
              left: 0,
              top: 10, // Fixed position from top instead of bottom
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),

            // Logo with text (centered independently) - using a single image asset
            Positioned(
              bottom: 2, // Position from top to center
              child: Image.asset(
                AppImages.logowithtext_img,
                height: 150, // Adjusted height
              ),
            ),

            // Right profile icon (independent positioning)
            Positioned(
              right: 0,
              top: 10, // Fixed position from top instead of bottom
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    // Handle profile icon tap
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => const D_ProfileScreen(),
                        ),);
                  },
                  child: const Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 24,
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