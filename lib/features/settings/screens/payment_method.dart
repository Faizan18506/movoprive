import 'package:flutter/material.dart';
import 'dart:io';

import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/settings/screens/AddCreditCardScreen.dart';
import 'package:movoprive/features/settings/widgets/GradientButton2.dart';



class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Payment',
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
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(

          children: [
            // You can replace this with your own Figma image using Image.asset or Image.network
            Image.asset(
              AppImages.credit_card, // Replace with your image path
              width: 250,
              height: 250,
              // If you don't have the image yet, you can comment this line out temporarily
              // errorBuilder: (context, error, stackTrace) {
              //   // return Container(
              //   //   width: 150,
              //   //   height: 150,
              //   //   alignment: Alignment.center,
              //   //   child: const Icon(
              //   //     Icons.card_giftcard,
              //   //     size: 80,
              //   //     color: Colors.orange,
              //   //   ),
              //   // );
              // },
            ),
            const Text(
              'To book your first ride, please add a payment method to your account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            GradientButton2(text: "ADD PAYMENT METHOD", onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCreditCardScreen(),
                ),
              );
            },),
          ],
        ),
    ),
    );
  }
}

