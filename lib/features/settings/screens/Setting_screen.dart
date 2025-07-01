import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Theme mode selection
  String _selectedTheme = 'system'; // 'system', 'light', 'dark'
  bool _systemThemeEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Go back logic here
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFCCAA00),
            height: 3.0,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // App appearance section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'App appearance',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // System settings option with switch
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: const Text(
              'System settings',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            leading: Radio(
              value: 'system',
              groupValue: _selectedTheme,
              onChanged: _systemThemeEnabled ? (String? value) {
                setState(() {
                  _selectedTheme = value!;
                });
              } : null,
              activeColor: Colors.black,
            ),
            trailing: Switch(
              value: _systemThemeEnabled,
              onChanged: (value) {
                setState(() {
                  _systemThemeEnabled = value;
                  if (value) {
                    _selectedTheme = 'system';
                  } else {
                    _selectedTheme = _selectedTheme == 'system' ? 'light' : _selectedTheme;
                  }
                });
              },
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFF4B0082),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[300],
              trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
              thumbColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return Colors.white;
              }),
              trackColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return const Color(0xFF8B7500);
                }
                return Colors.grey[300]!;
              }),
            ),
          ),

          // Divider
          const Divider(height: 1, thickness: 3, color: Color(0xFF410081)),

          // Always light option
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: const Text(
              'Always light',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            leading: Radio(
              value: 'light',
              groupValue: _selectedTheme,
              onChanged: (String? value) {
                setState(() {
                  _selectedTheme = value!;
                  _systemThemeEnabled = false;
                });
              },
              activeColor: Colors.purple[900],
            ),
            trailing: const Icon(Icons.light_mode, color: Colors.black),
          ),

          // Divider
          const Divider(height: 1, thickness: 3, color: Color(0xFF410081)),

          // Always dark option
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: const Text(
              'Always dark',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            leading: Radio(
              value: 'dark',
              groupValue: _selectedTheme,
              onChanged: (String? value) {
                setState(() {
                  _selectedTheme = value!;
                  _systemThemeEnabled = false;
                });
              },
              activeColor: Colors.purple[900],
            ),
            trailing: const Icon(Icons.dark_mode, color: Colors.black),
          ),

          // Divider
          const Divider(height: 1, thickness: 1, color: Color(0xFFFFFFFF)),

          const SizedBox(height: 24),

          // Account section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Delete account option
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: const Text(
              'Delete my account',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            leading: const Icon(Icons.delete, color: Colors.black),
            trailing: const Icon(Icons.chevron_left, color: Colors.black),
            onTap: () {
              _showDeleteAccountDialog();
            },
          ),

          // Divider
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Delete account logic would go here
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

// To use this screen in your app
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
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SettingsScreen(),
    );
  }
}