import 'package:flutter/material.dart';
import 'package:theft_detecting_system/features/all_widgets/custom_appbar.dart';
import 'package:theft_detecting_system/features/home/presentation/widgets/custom_drawer.dart';

class AccountPage extends StatefulWidget {
  static final String routeName = '/account';
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _allMotionAlert = false;
  bool _timeBasedAlert = false;
  bool _soundAlert = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Account Settings'),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Account Information Card
            Card(
              color: Colors.white.withAlpha(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          // Ensure this asset exists and is declared in pubspec.yaml.
                          backgroundImage: AssetImage('assets/placeholder.png'),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "John Doe",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "john.doe@example.com",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Logout logic goes here.
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Device Management Card
            Card(
              color: Colors.white.withAlpha(30),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Device Management",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Working Cameras Online",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "Camera 1",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Handle camera tap if needed.
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Test connection logic goes here.
                        },
                        child: const Text(
                          "Test Connection",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Notification Preference Card
            Card(
              color: Colors.white.withAlpha(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notification Preferences",
                      style: TextStyle(color: Colors.white),
                    ),
                    // All Motion Alert
                    ListTile(
                      title: const Text(
                        "All Motion Alert",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8, // Adjust the scale to make it smaller.
                        child: Switch(
                          value: _allMotionAlert,
                          onChanged: (bool value) {
                            setState(() {
                              _allMotionAlert = value;
                            });
                          },
                        ),
                      ),
                    ),
                    // Time Based Alert
                    ListTile(
                      title: const Text(
                        "Time Based Alert",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: _timeBasedAlert,
                          onChanged: (bool value) {
                            setState(() {
                              _timeBasedAlert = value;
                            });
                          },
                        ),
                      ),
                    ),
                    // Sound Alert
                    ListTile(
                      title: const Text(
                        "Sound Alert",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: _soundAlert,
                          onChanged: (bool value) {
                            setState(() {
                              _soundAlert = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
