import 'package:flutter/material.dart';
import 'package:movoprive/base/constants/app_images.dart';
import 'package:movoprive/features/settings/screens/Notification_screen.dart';
import 'package:movoprive/features/settings/screens/payment_method.dart';
import 'package:movoprive/features/settings/screens/peronal_info_screen.dart';
import 'package:movoprive/features/settings/screens/promotion_screen.dart';
import 'package:movoprive/features/authentication/services/auth_service.dart';
import 'package:movoprive/features/authentication/login/login_email.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movoprive/base/app_widget/app_toast.dart';

import '../../settings/screens/Setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _handleLogout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token == null) {
        AppToast.success('No active session found');
        return;
      }

      final authService = AuthService();
      await authService.logout(token);

      // Clear stored data
      await prefs.remove('token');
      await prefs.remove('userId');
      await prefs.remove('userEmail');

      // Navigate to login screen
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginEmailScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        AppToast.success('Failed to logout. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header image with welcome text
          Stack(
            children: [
              // Header image - chauffeur opening car door
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.grey, // Placeholder color
                ),
                child: ClipRRect(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Using a custom method to simulate the chauffeur image since we can't load external images
                      Image.asset(
                        AppImages.profile_screen_img,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
              // Welcome text overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Laura',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Menu items
          _buildMenuItem(
            icon: Icons.person,
            title: 'Personal information',
            onTap: ()  {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersonalInformationScreen(),
                ),
              );
            },
          ),

          _buildDivider(),

          _buildMenuItem(
            icon: Icons.credit_card,
            title: 'Payment',
            onTap: ()  {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentMethod(),
                ),
              );
            },
          ),

          _buildDivider(),

          _buildMenuItem(
            icon: Icons.star_border,
            title: 'Promotions',
            onTap: ()  {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PromotionsScreen(),
                ),
              );
            },
          ),

          _buildDivider(),

          _buildMenuItem(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationSettingsScreen(),
                ),
              );
            },
          ),

          _buildDivider(),

          _buildMenuItem(
            icon: Icons.settings,
            title: 'Settings',
           onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),

          _buildDivider(),

          _buildMenuItem(
            icon: Icons.logout,
            title: 'Log out',
            onTap: () => _handleLogout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 24,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 2,
      indent: 20,
      endIndent: 20,
      color: Color(0xFF5B466F),
    );
  }
}
