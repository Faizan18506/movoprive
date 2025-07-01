import 'package:flutter/material.dart';
import 'package:movoprive/base/app_widget/gradient_btn.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/booking/your_ride_Screen.dart';

import '../../booking/PickupLocationScreen.dart';
import 'availble_carScreen.dart';


class ThehourScreen extends StatefulWidget {
  const  ThehourScreen({Key? key}) : super(key: key);

  @override
  State< ThehourScreen> createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State< ThehourScreen> {
  bool isClassicSelected = true;
  bool isPremiumSelected = true;
  bool isPriveSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header image with close button
          Stack(
            children: [
              // The car interior image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    AppImages.hour_image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              // Close button
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),

          // Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    'By The Hour',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Ride options
                 RideOptionTile(
                    title: 'Movo Classic',
                    description: 'Budget-friendly hourly rides with flexible routing.Great for multiple errands, shopping trips, or quick stops around the city.',
                    isSelected: isClassicSelected,
                    onSelect: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PickupLocationScreen(carType: 'Movo Classic'),
                        ),
                      );
                    },
                  ),

                  const Divider(),

                  RideOptionTile(
                    title: 'Movo Premium',
                    description: 'Perfect for client meetings, events, or a day of appointments with upgraded vehicle comfort and convenience.',
                    isSelected: isPremiumSelected,
                    onSelect: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PickupLocationScreen(carType: 'Movo Premium'),
                        ),
                      );
                    },
                  ),
                  const Divider(),

                  RideOptionTile(
                    title: 'Movo Privé Black',
                    description: 'Your private chauffeur and vehicle, ready when you are.',
                    isSelected: isPriveSelected,
                    onSelect: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PickupLocationScreen(carType: 'Movo Privé Black'),
                        ),
                      );
                    },
                  ),

                  const Spacer(),

                  // Book now button
                 GradientButton(text: "Book now", onPressed: (){

                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const  PickupLocationScreen(carType: '',),

                     ),
                   );
                 },height: 50,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class RideOptionTile extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onSelect;

  const RideOptionTile({
    Key? key,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8), // Set radius to 8
              ),
              child: TextButton(
                onPressed: onSelect,
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Set radius to 8
                  ),
                ),
                child: const Text(
                  "Select",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }
}