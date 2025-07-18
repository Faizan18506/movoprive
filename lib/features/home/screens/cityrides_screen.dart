import 'package:flutter/material.dart';
import 'package:movoprive/base/app_widget/gradient_btn.dart';
import 'package:movoprive/base/constants/app_images.dart';

import '../../booking/PickupLocationScreen.dart';
import 'availble_carScreen.dart';


class CityridesScreen extends StatefulWidget {
  const  CityridesScreen({Key? key}) : super(key: key);

  @override
  State< CityridesScreen> createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State< CityridesScreen> {
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
                    AppImages.cityride_image,
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
                    'In-City Rides',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Ride options
                  RideOptionTile(
                    title: 'Movo Classic',
                    description: 'Effortless rides for every day.',
                    isSelected: isClassicSelected,
                    onSelect: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AvailableCarsScreen(availableDrivers: [],), // Replace with your target screen
                        ),
                      );
                      setState(() {
                        isClassicSelected = true;
                        isPremiumSelected = false;
                        isPriveSelected = false;
                      });
                    },
                  ),
                  const Divider(),

                  RideOptionTile(
                    title: 'Movo Premium',
                    description: 'Elevated comfort. Premium performance.',
                    isSelected: isPremiumSelected,
                    onSelect: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AvailableCarsScreen(availableDrivers: [],), // Replace with your target screen
                        ),
                      );
                      setState(() {
                        isClassicSelected = false;
                        isPremiumSelected = true;
                        isPriveSelected = false;
                      });
                    },
                  ),

                  const Divider(),

                  RideOptionTile(
                    title: 'Movo Privé',
                    description: 'Unparalleled luxury. Your personal concierge on wheels.',
                    isSelected: isPriveSelected,
                    onSelect: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AvailableCarsScreen(availableDrivers: [],), // Replace with your target screen
                        ),
                      );
                      setState(() {
                        isClassicSelected = false;
                        isPremiumSelected = false;
                        isPriveSelected = true;
                      });
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