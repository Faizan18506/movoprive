import 'package:flutter/material.dart';

import '../../main.dart';
       // Import the navigatorKey

        class GradientToast {
          static void show(String message) {
            final context = navigatorKey.currentContext; // Access the global context
            if (context == null) return; // Ensure context is not null

            final overlay = Overlay.of(context);
            final overlayEntry = OverlayEntry(
              builder: (context) => Positioned(
                bottom: 50.0,
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF333333), // Dark blue/black
                          Color(0xFF2D0A53), // Deep purple
                          Color(0xFF8B7500), // Gold/amber
                        ],
                        stops: [0.0, 0.3, 0.6],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );

            overlay?.insert(overlayEntry);

            // Remove the toast after 3 seconds
            Future.delayed(const Duration(seconds: 3), () {
              overlayEntry.remove();
            });
          }
        }