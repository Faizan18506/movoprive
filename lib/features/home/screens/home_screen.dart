import 'package:flutter/material.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/home/screens/cityrides_screen.dart';
import 'package:movoprive/features/home/screens/hour_Screen.dart';
import 'package:movoprive/features/home/screens/partbus_screen.dart';

import '../widgets/FeatureCard.dart';
import '../widgets/service_card.dart';
import 'airport_transfer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

  class _HomeScreen extends State<HomeScreen> {
  final PageController _pageController = PageController();
  bool isPriveSelected = true;
  int _currentPage = 0;

  final List<Map<String, dynamic>> _sliderImages = [
  {
  'image': 'assets/home_screen/home_img_1.png',
  'title': '',
  'description': ''
  },
  {
  'image': 'assets/home_screen/home_img_2.png',
  'title': 'VIP Experience',
  'description': 'Premium entertainment and luxury on the go.'
  },
  {
  'image': 'assets/home_screen/home_img_3.png',
  'title': 'Ultimate Party',
  'description': 'Dance floor, lights, and sound system included.'
  },
  ];

  @override
  void initState() {
  super.initState();
  _pageController.addListener(() {
  int next = _pageController.page!.round();
  if (_currentPage != next) {
  setState(() {
  _currentPage = next;
  });
  }
  });
  }

  @override
  void dispose() {
  _pageController.dispose();
  super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top section with image, greeting and search bar
          Stack(
            children: [
              // Background image
              Image.asset(
               AppImages.Top_image,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),
              // Dark overlay
              Container(
                width: double.infinity,
                height: 240,
                color: Colors.black.withOpacity(0.2),
              ),
              // Greeting and search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 110, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting
                    const Text(
                      'Hi Laura\nYour personal chauffeur\nAlways on time. ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                   Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF333333),   // 0% - Dark blue/black
                            Color(0xFF2D0A53),   // 30% - Deep purple
                            Color(0xFF8B7500),   // 60% - Gold/amber
                          ],
                          stops: [0.0, 0.3, 0.6],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        child: Row(
                          children: [
                            Text(
                              'Where to?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          // Our Services section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Our Services',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Service options in grid
                Row(
                  children: [
                    Expanded(
                      child: ServiceCard(
                        title: 'By The Hour',
                        description: 'our personal chauffeur, on standby. ',
                        iconAsset: AppImages.by_hour_icon,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const ThehourScreen()));
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ServiceCard(
                        title: 'In-City Rides',
                        description: 'Effortless everyday rides  ',
                        iconAsset: AppImages.city_rides_icon,
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const CityridesScreen()));},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ServiceCard(
                        title: 'Party Bus',
                        description: 'Your party on wheels. ',
                        iconAsset: AppImages.party_bus_icon,
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const PartyBusScreen()));},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ServiceCard(
                        title: 'Airport Transfer',
                        description: 'Seamless travel from gate to curb.',
                        iconAsset:AppImages.airport_icon,
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const AirportTransferScreen()));},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom cards with images
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _sliderImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            fit: StackFit.passthrough,
                            children: [
                              Image.asset(
                                _sliderImages[index]['image'],
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.8),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _sliderImages[index]['title'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _sliderImages[index]['description'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Page indicator

              ],
            ),
          ),
        ],
      ),
    );
  }
}


