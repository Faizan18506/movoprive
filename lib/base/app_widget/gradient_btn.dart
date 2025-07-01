import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;

  const GradientButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.height = 40.0,
    this.horizontalPadding = 20.0,
    this.verticalPadding = 10.0,
    this.borderRadius = 30.0,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.bold,
    this.letterSpacing = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
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
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.25),
        //     blurRadius: 8,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                      letterSpacing: letterSpacing,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
