import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientFooter extends StatelessWidget {
  final VoidCallback onSignUpTap;


  const GradientFooter({
    Key? key,
    required this.onSignUpTap,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF333333), // 0% - Dark blue/black
            Color(0xFF2D0A53), // 30% - Deep purple
            Color(0xFF8B7500), // 60% - Gold/amber
          ],
          stops: [0.0, 0.3, 0.6],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onSignUpTap,
            child: const Text(
              "Don't have an account yet?\nBecome a partner?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // GestureDetector(
          //   onTap: onBecomePartnerTap,
          //   child: const Text(
          //     "Become a partner?",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 14,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}