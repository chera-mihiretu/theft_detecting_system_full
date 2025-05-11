import 'package:flutter/material.dart';
import 'package:theft_detecting_system/features/all_widgets/custom_appbar.dart';
import 'package:theft_detecting_system/features/home/presentation/widgets/custom_drawer.dart';

class NotificationPage extends StatelessWidget {
  static final String routeName = '/notification';
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: CustomAppbar(title: 'Notifications'),
      body: ListView.builder(
        itemCount: 10, // Replace with your notifications count
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white.withAlpha(30),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image displayer covering the full width of the card
                  Image.asset(
                    'assets/placeholder.png',
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  // Title text
                  const Text(
                    'Motion Detected',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Description text with current detected time
                  Text(
                    'Detected at ${DateTime.now().toLocal().toString().split(".")[0]}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  // Button placed vertically at the bottom
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement view recording functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Set button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // Set border radius (not fully rounded)
                      ),
                    ),
                    child: const Text(
                      'View Recording',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
