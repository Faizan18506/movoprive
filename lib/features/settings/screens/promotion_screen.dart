import 'package:flutter/material.dart';
import 'dart:io';

import 'package:movoprive/base/constants/app_images.dart';



class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Promotions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back navigation
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Color(0xFF8B7500),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // You can replace this with your own Figma image using Image.asset or Image.network
            Image.asset(
              AppImages.no_promotion_image, // Replace with your image path
              width: 150,
              height: 150,
              // If you don't have the image yet, you can comment this line out temporarily
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 150,
                  height: 150,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.card_giftcard,
                    size: 80,
                    color: Colors.orange,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'No promotion available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'There are no promotion available in your account at this time',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

