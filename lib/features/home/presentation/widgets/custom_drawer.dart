import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final List<Map<String, dynamic>> items = const [
    {'title': 'Stream', 'icon': Icons.stream},
    {'title': 'Notification', 'icon': Icons.notifications},
    {'title': 'Account', 'icon': Icons.person},
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0A0F1C),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF1F2533)),
            child: Row(
              children: [
                // Logo with increased border radius
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/logo.png', // ensure the logo is added to your assets and declared in pubspec.yaml
                    height: 60,
                  ),
                ),
                const SizedBox(width: 16),
                // Title and description on the right
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Theft Detector System',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'An app to monitor and detect theft.',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Space between header and item list
          const SizedBox(height: 10),
          // List of drawer items
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return ListTile(
              tileColor: Colors.transparent,
              // Updated color for selected item
              selectedTileColor: const Color(0xFF3E54D4),
              selected: index == _selectedIndex,
              leading: Icon(item['icon'], color: Colors.white),
              title: Text(
                item['title'],
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                // Handle further actions if needed.
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
