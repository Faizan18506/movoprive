import 'package:flutter/material.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/booking/PickupLocationScreen.dart';
import 'package:movoprive/features/settings/widgets/GradientButton2.dart';

import 'availble_carScreen.dart';


class PartyBusScreen extends StatefulWidget {
  const PartyBusScreen({Key? key}) : super(key: key);

  @override
  State<PartyBusScreen> createState() => _PartyBusScreenState();
}

class _PartyBusScreenState extends State<PartyBusScreen> {
  final PageController _pageController = PageController();
  bool isPriveSelected = true;
  int _currentPage = 0;

  final List<Map<String, dynamic>> _sliderImages = [
    {
      'image': 'assets/home_screen/party_on_wheel.png',
      'title': 'Party On Wheels',
      'description': 'Where the journey is just as exciting as the destination.'
    },
    {
      'image': 'assets/home_screen/party_on_wheel.png',
      'title': 'VIP Experience',
      'description': 'Premium entertainment and luxury on the go.'
    },
    {
      'image': 'assets/home_screen/party_on_wheel.png',
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header image
          Container(
            height: 220,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Image.asset(
              AppImages.party_bus,
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    'Party Bus',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Movo Privé Black Charter option
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mova Privé Charter',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Unparalleled luxury. Your personal concierge on wheels. Your private club on the move — where the journey is the party.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                     GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AvailableCarsScreen(availableDrivers: [],), // Replace with your target screen
                            ),
                          );

                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey, // Grey container
                            borderRadius: BorderRadius.circular(4), // Rounded corners with radius 4
                          ),
                          child: Text(
                            'Select',
                            style: const TextStyle(
                              color: Colors.white, // Text color
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  const Divider(height: 32),

                  // Slider
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
                                    fit: StackFit.expand,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_sliderImages.length, (index) {
                            return Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index
                                    ? Colors.purple
                                    : Colors.grey.withOpacity(0.5),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Book now button
                 Center(child: GradientButton2(text: "Book Now", onPressed: (){

                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const  PickupLocationScreen(carType: '',),

                     ),
                   );
                 },))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}