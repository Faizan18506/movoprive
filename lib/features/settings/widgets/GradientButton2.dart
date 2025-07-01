import 'package:flutter/material.dart';

    class GradientButton2 extends StatelessWidget {
      final String text;
      final VoidCallback? onPressed;

      const GradientButton2({
        Key? key,
        required this.text,
        this.onPressed,
      }) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return SizedBox(
          width: 300, // Set a fixed width
          height: 50, // Set a fixed height
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [Color(0xFF2D0A53), Color(0xFF8B7500)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }
    }