import 'package:flutter/material.dart';
import 'package:movoprive/features/Driver_side/DashBoard/D_PlannedScreen.dart';
import 'package:movoprive/features/Driver_side/DashBoard/D_offerScreen.dart';
import '../../Driver_side/DashBoard/D_FinishScreen.dart';
import '../../Driver_side/DashBoard/DriverHomeScreen.dart';
import '../../home/screens/home_screen.dart';
import '../../rides/screens/rides_screen.dart';
import '../../help/screens/help_screen.dart';
import '../../profile/screens/profile_screen.dart';

class DriverMainScreen extends StatefulWidget {
  const DriverMainScreen({Key? key}) : super(key: key);

  @override
  State<DriverMainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<DriverMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DriverHomeScreen(),
    const D_OffersScreen(),
    const D_PlannedScreen(),
    const D_FinishScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Stack(
        children: [
          // Gradient background
          Container(
            height: kBottomNavigationBarHeight + 16,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF333333), // 0%
                  Color(0xFF2D0A53), // 30%
                  Color(0xFF8B7500), // 60%
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 0.3, 0.6],
              ),
            ),
          ),
          // BottomNavigationBar
          BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/driver_Side/Home_Page.png', // Replace with your Figma icon path
                  width: 24, // Adjust the size as needed
                  height: 24,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/driver_Side/Black_Friday_Tag.png', // Replace with your Figma icon path
                  width: 24,
                  height: 24,
                ),
                label: 'offers',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/driver_Side/To_Do.png', // Replace with your Figma icon path
                  width: 24,
                  height: 24,
                ),
                label: 'Planned',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/driver_Side/Check_Mark.png', // Replace with your Figma icon path
                  width: 24,
                  height: 24,
                ),
                label: 'Finish',
              ),
            ],
          ),
        ],
      ),
    );
  }
}