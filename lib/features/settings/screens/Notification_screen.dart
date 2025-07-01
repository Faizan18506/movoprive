import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF2D0A53),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const NotificationSettingsScreen(),
    );
  }
}

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // Toggle states for notification settings
  bool pushNotificationsEnabled = false; // Set to false as per design
  bool ridesEnabled = true;
  bool marketingEnabled = true;
  bool textMessagesEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please select at least one notification channel for your rides',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),

            // Push notification section
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Push notification',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Rides
            _buildToggleItem(
              title: 'Rides',
              subtitle: 'Ride status, rate the ride',
              isEnabled: ridesEnabled,
              onChanged: (value) {
                setState(() {
                  ridesEnabled = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // Marketing
            _buildToggleItem(
              title: 'Marketing',
              subtitle: 'Personalized updates and offers, curated travel tips, feedback requests',
              isEnabled: marketingEnabled,
              onChanged: (value) {
                setState(() {
                  marketingEnabled = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Text messages header
            const Text(
              'Text messages',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Rides (Text messages)
            _buildToggleItem(
              title: 'Rides',
              subtitle: 'Ride status',
              isEnabled: textMessagesEnabled,
              onChanged: (value) {
                setState(() {
                  textMessagesEnabled = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Email note
            const Text(
              'Ride status updates are also always sent via email',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required String? subtitle,
    required bool isEnabled,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Switch(
          value: isEnabled,
          onChanged: onChanged,
          activeTrackColor: Color(0xFF8B7500), // Gold color for track
          activeColor: Color(0xFF2D0A53), // Deep purple for thumb
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    );
  }
}